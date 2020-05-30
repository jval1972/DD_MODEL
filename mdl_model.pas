//------------------------------------------------------------------------------
//
//  DD_MODEL: DelphiDOOM Procedural Model Editor
//  Copyright (C) 2017 by Jim Valavanis
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
// DESCRIPTION:
//  Model loader
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit mdl_model;

interface

uses
  dglOpenGL,
  SysUtils,
  Classes,
  mdl_utils;

type
  modelcmd_t = record
    cmd: integer;
    params: array[0..3] of GLfloat;
    frame: integer;
  end;
  modelcmd_p = ^modelcmd_t;
  modelcmd_a = array[0..$FFF] of modelcmd_t;
  modelcmd_pa = ^modelcmd_a;

const
  C_glBegin = 0;
  C_glEnd = 1;
  C_glTexCoord2f = 2;
  C_glVertex3f = 3;
  C_glColor3f = 4;
  C_glColor4f = 5;
  C_glNormal3f = 6;
  C_glMatrixMode = 7;
  C_glPushMatrix = 8;
  C_glPopMatrix = 9;
  C_glTranslatef = 10;
  C_glRotatef = 11;
  C_glLoadIdentity = 12;
  C_glScalef = 13;
  C_SetFrame = 14;
  C_CallFrame = 15;

const
  MDL_MAGIC = $1;

type
  scriptlanguage_t = (sl_pascal, sl_modelddscript, sl_clang);

  TDDModelLoader = class(TObject)
  private
    fNumCmds: integer;
    fRealNumCmds: integer;
    fCmds: modelcmd_pa;
    fcurrentframe: integer;
    frecursiondepth: integer;
    fmaxrecursiondepth: integer;
    frecursionframes: TDNumberList;
    FFrames: TDNumberList;
    function Grow: modelcmd_p;
  protected
    procedure AddCmd(const cmd: integer; const parm0: Single = 0.0;
      const parm1: Single = 0.0; const parm2: Single = 0.0; const parm3: Single = 0.0);
    procedure DoRenderFrame(const frm: integer); virtual;
    procedure DoRenderTextureMask(const frm: integer; const W, H: integer); virtual;
    procedure IdentifyFrames;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Clear;
    function LoadFromScript(const aScript: string): boolean;
    function AppendFromScript(const aScript: string): boolean;
    function LoadFromStream(const aStream: TStream): boolean;
    function AppendFromStream(const aStream: TStream): boolean;
    function LoadFromFile(const aFileName: string): boolean;
    function AppendFromFile(const aFileName: string): boolean;
    procedure SaveToStream(const aStream: TStream);
    procedure SaveToFile(const aFileName: string);
    procedure RenderFrame(const frm: integer);
    procedure RenderTextureMask(const frm: integer; const W, H: integer);
    function Decompile(const lang: scriptlanguage_t): string;
    property MaxRecursionDepth: Integer read fmaxrecursiondepth write fmaxrecursiondepth;
    property CurrentFrame: Integer read fcurrentframe write fcurrentframe;
    property Frames: TDNumberList read FFrames;
  end;

procedure MDLS_glBegin(const mode: GLenum);
procedure MDLS_glEnd;
procedure MDLS_glTexCoord2f(const s, t: GLfloat);
procedure MDLS_glVertex3f(const x, y, z: GLfloat);
procedure MDLS_glColor3f(const r, g, b: GLfloat);
procedure MDLS_glColor4f(const r, g, b, a: GLfloat);
procedure MDLS_glNormal3f(const nx, ny, nz: GLfloat);
procedure MDLS_glMatrixMode(const mode: LongWord);
procedure MDLS_glPushMatrix;
procedure MDLS_glPopMatrix;
procedure MDLS_glTranslatef(const x, y, z: GLfloat);
procedure MDLS_glRotatef(const a, x, y, z: GLfloat);
procedure MDLS_glLoadIdentity;
procedure MDLS_glScalef(const x, y, z: GLfloat);
procedure MDLS_SetFrame(const frm: integer);
procedure MDLS_CallFrame(const frm: integer);

implementation

uses
  mdl_script,
  mdl_script_functions;

var
  currentmodelloader: TDDModelLoader;

constructor TDDModelLoader.Create;
begin
  fNumCmds := 0;
  fRealNumCmds := 0;
  fCmds := nil;
  fcurrentframe := 0;
  frecursiondepth := 0;
  fmaxrecursiondepth := 20;
  FFrames := TDNumberList.Create;
  frecursionframes := TDNumberList.Create;
  inherited;
end;

destructor TDDModelLoader.Destroy;
begin
  Clear;
  FFrames.Free;
  frecursionframes.Free;
  inherited;
end;

function TDDModelLoader.Grow: modelcmd_p;
begin
  Inc(fNumCmds);
  if fNumCmds >= fRealNumCmds then
  begin
    fRealNumCmds := fRealNumCmds + 16;
    ReallocMem(fCmds, fRealNumCmds * SizeOf(modelcmd_t));
  end;
  Result := @fCmds[fNumCmds - 1];
end;

procedure TDDModelLoader.AddCmd(const cmd: integer; const parm0: Single = 0.0;
  const parm1: Single = 0.0; const parm2: Single = 0.0; const parm3: Single = 0.0);
var
  pc: modelcmd_p;
begin
  pc := Grow;
  pc.cmd := cmd;
  pc.params[0] := parm0;
  pc.params[1] := parm1;
  pc.params[2] := parm2;
  pc.params[3] := parm3;
  pc.frame := fcurrentframe;
end;

procedure TDDModelLoader.Clear;
begin
  ReallocMem(fCmds, 0);
  fNumCmds := 0;
  fRealNumCmds := 0;
  fcurrentframe := 0;
  frecursiondepth := 0;
  FFrames.Clear;
end;

function TDDModelLoader.LoadFromScript(const aScript: string): boolean;
begin
  Clear;
  Result := AppendFromScript(aScript);
end;

function TDDModelLoader.AppendFromScript(const aScript: string): boolean;
begin
  currentmodelloader := Self;
  Result := MDL_ExecuteScript(aScript);
  IdentifyFrames;
end;

function TDDModelLoader.LoadFromStream(const aStream: TStream): boolean;
begin
  Clear;
  Result := AppendFromStream(aStream);
end;

function TDDModelLoader.AppendFromStream(const aStream: TStream): boolean;
var
  header: integer;
  sz: integer;
begin
  aStream.Read(header, SizeOf(integer));
  if header <> MDL_MAGIC then
  begin
    Result := False;
    Exit;
  end;
  aStream.Read(sz, SizeOf(integer));
  if sz < 0 then
  begin
    Result := False;
    Exit;
  end;
  fNumCmds := sz;
  fRealNumCmds := sz;
  ReallocMem(fCmds, fNumCmds * SizeOf(modelcmd_t));
  aStream.Read(fCmds^, fNumCmds * SizeOf(modelcmd_t));
  IdentifyFrames;
  Result := True;
end;

function TDDModelLoader.LoadFromFile(const aFileName: string): boolean;
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(aFileName, fmOpenRead);
  try
    Result := LoadFromStream(fs);
  finally
    fs.Free;
  end;
end;

function TDDModelLoader.AppendFromFile(const aFileName: string): boolean;
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(aFileName, fmOpenRead);
  try
    Result := AppendFromStream(fs);
  finally
    fs.Free;
  end;
end;

procedure TDDModelLoader.SaveToStream(const aStream: TStream);
var
  header: integer;
  sz: integer;
begin
  header := MDL_MAGIC;
  aStream.Write(header, SizeOf(integer));
  sz := fNumCmds;
  aStream.Write(sz, SizeOf(integer));
  aStream.Write(fCmds^, sz * SizeOf(modelcmd_t));
end;

procedure TDDModelLoader.SaveToFile(const aFileName: string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(aFileName, fmOpenReadWrite or fmCreate);
  try
    SaveToStream(fs);
  finally
    fs.Free;
  end;
end;

procedure TDDModelLoader.RenderFrame(const frm: integer);
begin
  frecursiondepth := 0;
  frecursionframes.Clear;
  DoRenderFrame(frm);
end;

procedure TDDModelLoader.DoRenderFrame(const frm: integer);
var
  i: integer;
  pc: modelcmd_p;
  idx: integer;
begin
  if frecursiondepth >= fmaxrecursiondepth then
    Exit;
  if frecursionframes.IndexOf(frm) >= 0 then
    Exit;
  frecursionframes.Add(frm);

  Inc(frecursiondepth);
  for i := 0 to fNumCmds - 1 do
  begin
    pc := @fCmds[i];
    if frm <> pc.frame then
      Continue;

    case pc.cmd of
      C_glBegin:
        glBegin(Round(pc.params[0]));
      C_glEnd:
        glEnd;
      C_glTexCoord2f:
        glTexCoord2f(pc.params[0], pc.params[1]);
      C_glVertex3f:
        glVertex3f(pc.params[0], pc.params[1], pc.params[2]);
      C_glColor3f:
        glColor3f(pc.params[0], pc.params[1], pc.params[2]);
      C_glColor4f:
        glColor4f(pc.params[0], pc.params[1], pc.params[2], pc.params[3]);
      C_glNormal3f:
        glNormal3f(pc.params[0], pc.params[1], pc.params[2]);
      C_glMatrixMode:
        glMatrixMode(Round(pc.params[0]));
      C_glPushMatrix:
        glPushMatrix;
      C_glPopMatrix:
        glPopMatrix;
      C_glTranslatef:
        glTranslatef(pc.params[0], pc.params[1], pc.params[2]);
      C_glRotatef:
        glRotatef(pc.params[0], pc.params[1], pc.params[2], pc.params[3]);
      C_glLoadIdentity:
        glLoadIdentity;
      C_glScalef:
        glScalef(pc.params[0], pc.params[1], pc.params[2]);
      C_CallFrame:
        DoRenderFrame(Round(pc.params[0]));
    end;
  end;

  idx := frecursionframes.IndexOf(frm);
  if idx >= 0 then
    frecursionframes.Delete(idx);

  Dec(frecursiondepth);
end;

procedure TDDModelLoader.RenderTextureMask(const frm: integer; const W, H: integer);
begin
  frecursiondepth := 0;
  frecursionframes.Clear;
  DoRenderTextureMask(frm, W, H);
end;

procedure TDDModelLoader.DoRenderTextureMask(const frm: integer; const W, H: integer);
var
  x, y: GLfloat;
  i: integer;
  pc: modelcmd_p;
  idx: integer;
begin
  if frecursiondepth >= fmaxrecursiondepth then
    Exit;
  if frecursionframes.IndexOf(frm) >= 0 then
    Exit;
  frecursionframes.Add(frm);

  Inc(frecursiondepth);
  x := 0.0;
  y := 0.0;
  for i := 0 to fNumCmds - 1 do
  begin
    pc := @fCmds[i];
    if pc.frame <> frm then
      Continue;
    case pc.cmd of
      C_glBegin:
        glBegin(Round(pc.params[0]));
      C_glEnd:
        glEnd;
      C_glTexCoord2f:
        begin
          x := pc.params[0];
          y := pc.params[1];
          glTexCoord2f(x, y);
        end;
      C_glVertex3f:
        glVertex2i(Round(x * W), Round(H - y * H));
      C_CallFrame:
        DoRenderTextureMask(Round(pc.params[0]), W, H);
    end;
  end;

  idx := frecursionframes.IndexOf(frm);
  if idx >= 0 then
    frecursionframes.Delete(idx);

  Dec(frecursiondepth);
end;

function TDDModelLoader.Decompile(const lang: scriptlanguage_t): string;
var
  stmp: TStringList;
  sprocs: TStringList;
  i, idx, _frm: integer;
  pc: modelcmd_p;
  cparenth: string;

  function _glbeginstr(const x: integer): string;
  begin
    case x of
      GL_LINES:
        Result := 'GL_LINES';
      GL_LINE_LOOP:
        Result := 'GL_LINE_LOOP';
      GL_LINE_STRIP:
        Result := 'GL_LINE_STRIP';
      GL_TRIANGLES:
        Result := 'GL_TRIANGLES';
      GL_TRIANGLE_STRIP:
        Result := 'GL_TRIANGLE_STRIP';
      GL_TRIANGLE_FAN:
        Result := 'GL_TRIANGLE_FAN';
      GL_QUADS:
        Result := 'GL_QUADS';
      GL_QUAD_STRIP:
        Result := 'GL_QUAD_STRIP';
      GL_POLYGON:
        Result := 'GL_POLYGON';
    else
      Result := IntToStr(x);
    end;
  end;

  function _glmatrixmodestr(const x: integer): string;
  begin
    case x of
      GL_MODELVIEW:
        Result := 'GL_MODELVIEW';
      GL_PROJECTION:
        Result := 'GL_PROJECTION';
      GL_TEXTURE:
        Result := 'GL_TEXTURE';
      GL_COLOR:
        Result := 'GL_COLOR';
    else
      Result := IntToStr(x);
    end;
  end;

  function _FF(const x: GLFloat): string;
  begin
    if lang = sl_clang then
    begin
      Result := Format('%2.15f', [x]);
      if Pos('.', Result) = 0 then
        Result := Result + '.0';
      while Result[Length(Result)] = '0' do
        SetLength(Result, Length(Result) - 1);
      if Result[Length(Result)] = '.' then
        Result := Result + '0';
      Result := Result + 'f';
    end
    else
      Result := Format('%g', [x]);
  end;

begin
  Result := '';

  if fNumCmds = 0 then
    Exit;

  IdentifyFrames; // JVAL: Just to be sure :)

  if lang = sl_clang then
    cparenth := '()'
  else
    cparenth := '';
  sprocs := TStringList.Create;
  try
    for i := 0 to FFrames.Count - 1 do
    begin
      stmp := TStringList.Create;
      if lang = sl_modelddscript then
        stmp.Add(Format('  SetFrame(%d);', [FFrames.Numbers[i]]));
      sprocs.AddObject(Format('frame_%d', [FFrames.Numbers[i]]), stmp);
    end;

    for i := 0 to fNumCmds - 1 do
    begin
      pc := @fCmds[i];
      _frm := pc.frame;
      idx := FFrames.IndexOf(_frm);
      stmp := sprocs.Objects[idx] as TStringList;

      case pc.cmd of
        C_glBegin:
          stmp.Add(Format('  %s(%s);', ['glBegin', _glbeginstr(Round(pc.params[0]))]));
        C_glEnd:
          stmp.Add(Format('  %s%s;', ['glEnd', cparenth]));
        C_glTexCoord2f:
          stmp.Add(Format('    %s(%s, %s);', ['glTexCoord2f', _FF(pc.params[0]), _FF(pc.params[1])]));
        C_glVertex3f:
          stmp.Add(Format('    %s(%s, %s, %s);', ['glVertex3f', _FF(pc.params[0]), _FF(pc.params[1]), _FF(pc.params[2])]));
        C_glColor3f:
          stmp.Add(Format('    %s(%s, %s, %s);', ['glColor3f', _FF(pc.params[0]), _FF(pc.params[1]), _FF(pc.params[2])]));
        C_glColor4f:
          stmp.Add(Format('    %s(%s, %s, %s, %s);', ['glColor4f', _FF(pc.params[0]), _FF(pc.params[1]), _FF(pc.params[2]), _FF(pc.params[3])]));
        C_glNormal3f:
          stmp.Add(Format('    %s(%s, %s, %s);', ['glNormal3f', _FF(pc.params[0]), _FF(pc.params[1]), _FF(pc.params[2])]));
        C_glMatrixMode:
          stmp.Add(Format('  %s(%s);', ['glMatrixMode', _glmatrixmodestr(Round(pc.params[0]))]));
        C_glPushMatrix:
          stmp.Add(Format('  %s%s;', ['glPushMatrix', cparenth]));
        C_glPopMatrix:
          stmp.Add(Format('  %s%s;', ['glPopMatrix', cparenth]));
        C_glTranslatef:
          stmp.Add(Format('  %s(%s, %s, %s);', ['glTranslatef', _FF(pc.params[0]), _FF(pc.params[1]), _FF(pc.params[2])]));
        C_glRotatef:
          stmp.Add(Format('  %s(%s, %s, %s, %s);', ['glRotatef', _FF(pc.params[0]), _FF(pc.params[1]), _FF(pc.params[2]), _FF(pc.params[3])]));
        C_glLoadIdentity:
          stmp.Add(Format('  %s%s;', ['glLoadIdentity', cparenth]));
        C_glScalef:
          stmp.Add(Format('  %s(%s, %s, %s);', ['glScalef', _FF(pc.params[0]), _FF(pc.params[1]), _FF(pc.params[2])]));
        C_CallFrame:
          stmp.Add(Format('  frame_%d%s;', [Round(pc.params[0]), cparenth]));
      end;
    end;

    case lang of
      sl_modelddscript:
        begin
          Result := 'model model1;'#13#10#13#10;
          for i := 0 to sprocs.Count - 1 do
            Result := Result + ('procedure ' + sprocs.Strings[i] + '; forward;'#13#10#13#10);
        end;
      sl_pascal:
        begin
          Result := 'unit model1;'#13#10#13#10'interface'#13#10#13#10'uses'#13#10'  dglOpenGL;'#13#10#13#10;
          for i := 0 to sprocs.Count - 1 do
            Result := Result + ('procedure ' + sprocs.Strings[i] + ';'#13#10);
        end;
      sl_clang:
        begin
          Result := '#include <GL/gl.h>'#13#10#13#10;
          for i := 0 to sprocs.Count - 1 do
            Result := Result + ('void ' + sprocs.Strings[i] + '();'#13#10);
        end;
    end;

    if lang = sl_pascal then
      Result := Result + #13#10'implementation'#13#10#13#10
    else
      Result := Result + #13#10;

    for i := 0 to sprocs.Count - 1 do
    begin
      if lang = sl_clang then
        Result := Result + ('void ' + sprocs.Strings[i] + '()'#13#10'{'#13#10)
      else
        Result := Result + ('procedure ' + sprocs.Strings[i] + ';'#13#10'begin'#13#10);
      stmp := sprocs.Objects[i] as TStringList;
      if lang = sl_clang then
        Result := Result + stmp.Text + '}'#13#10#13#10
      else
        Result := Result + stmp.Text + 'end;'#13#10#13#10;
    end;

    if lang = sl_modelddscript then
    begin
      Result := Result + 'begin'#13#10;
      for i := 0 to sprocs.Count - 1 do
        Result := Result + ('  ' + sprocs.Strings[i] + ';'#13#10);
    end;
    if lang <> sl_clang then
    Result := Result + 'end.'#13#10;
  finally
    for i := 0 to sprocs.Count - 1 do
      sprocs.Objects[i].Free;
    sprocs.Free;
  end;
end;

procedure TDDModelLoader.IdentifyFrames;
var
  i: integer;
  pc: modelcmd_p;
  frm: integer;
begin
  FFrames.Clear;
  for i := 0 to fNumCmds - 1 do
  begin
    pc := @fCmds[i];
    if FFrames.IndexOf(pc.frame) < 0 then
      FFrames.Add(pc.frame);
    if pc.cmd = C_CallFrame then
    begin
      frm := Round(pc.params[0]);
      if FFrames.IndexOf(frm) < 0 then
        FFrames.Add(frm);
    end;
  end;
  FFrames.Sort;
end;

//-------------------------- PascalScript Functions ----------------------------

procedure MDLS_glBegin(const mode: GLenum);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glBegin(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glBegin, mode);
end;

procedure MDLS_glEnd;
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glEnd(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glEnd);
end;

procedure MDLS_glTexCoord2f(const s, t: GLfloat);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glTexCoord2f(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glTexCoord2f, s, t);
end;

procedure MDLS_glVertex3f(const x, y, z: GLfloat);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glVertex3f(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glVertex3f, x, y, z);
end;

procedure MDLS_glColor3f(const r, g, b: GLfloat);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glColor3f(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glColor3f, r, g, b);
end;

procedure MDLS_glColor4f(const r, g, b, a: GLfloat);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glColor4f(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glColor4f, r, g, b, a);
end;

procedure MDLS_glNormal3f(const nx, ny, nz: GLfloat);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glNormal3f(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glNormal3f, nx, ny, nz);
end;

procedure MDLS_glMatrixMode(const mode: LongWord);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glMatrixMode(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glMatrixMode, mode);
end;

procedure MDLS_glPushMatrix;
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glPushMatrix(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glPushMatrix);
end;

procedure MDLS_glPopMatrix;
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glPopMatrix(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glPopMatrix);
end;

procedure MDLS_glTranslatef(const x, y, z: GLfloat);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glTranslatef(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glTranslatef, x, y, z);
end;

procedure MDLS_glRotatef(const a, x, y, z: GLfloat);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glRotatef(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glRotatef, a, x, y, z);
end;

procedure MDLS_glLoadIdentity;
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glLoadIdentity(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glLoadIdentity);
end;

procedure MDLS_glScalef(const x, y, z: GLfloat);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_glScalef(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_glScalef, x, y, z);
end;

procedure MDLS_SetFrame(const frm: integer);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_SetFrame(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.CurrentFrame := frm;
  currentmodelloader.AddCmd(C_SetFrame, frm);
end;

procedure MDLS_CallFrame(const frm: integer);
begin
  if currentmodelloader = nil then
  begin
    printf('MDLS_CallFrame(): No model loader available'#13#10);
    Exit;
  end;
  currentmodelloader.AddCmd(C_CallFrame, frm);
end;

end.
