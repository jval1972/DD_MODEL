//------------------------------------------------------------------------------
//
//  DD_MODEL: DelphiDOOM Procedural Model Editor
//  Copyright (C) 2017-2021 by Jim Valavanis
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
//  Main Form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Buttons, Clipbrd, ExtDlgs, pngimage, xTGA, jpeg,
  zBitmap, Menus, ImgList, StdCtrls, dglOpenGL;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    SavePictureDialog1: TSavePictureDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    OpenTexture1: TMenuItem;
    SaveAs3D: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Model1: TMenuItem;
    CopyTexture1: TMenuItem;
    Copy3d: TMenuItem;
    N2: TMenuItem;
    PasteTexture1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    Timer1: TTimer;
    TexturePopupMenu: TPopupMenu;
    PreviewPopupMenu: TPopupMenu;
    Copy2: TMenuItem;
    Save1: TMenuItem;
    Open2: TMenuItem;
    Copy3: TMenuItem;
    Paste2: TMenuItem;
    Save2: TMenuItem;
    exture1: TMenuItem;
    Pewview1: TMenuItem;
    New1: TMenuItem;
    SaveAs2: TMenuItem;
    N3: TMenuItem;
    Compile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    FileMenuHistoryItem0: TMenuItem;
    FileMenuHistoryItem1: TMenuItem;
    FileMenuHistoryItem2: TMenuItem;
    FileMenuHistoryItem3: TMenuItem;
    FileMenuHistoryItem4: TMenuItem;
    FileMenuHistoryItem5: TMenuItem;
    FileMenuHistoryItem6: TMenuItem;
    FileMenuHistoryItem7: TMenuItem;
    FileMenuHistoryItem8: TMenuItem;
    FileMenuHistoryItem9: TMenuItem;
    N4: TMenuItem;
    EditorPopupMenu: TPopupMenu;
    New2: TMenuItem;
    Save3: TMenuItem;
    SaveAs1: TMenuItem;
    Open3: TMenuItem;
    Options1: TMenuItem;
    N5: TMenuItem;
    SaveAsTexture1: TMenuItem;
    N6: TMenuItem;
    SaveAs3: TMenuItem;
    N7: TMenuItem;
    Mask1: TMenuItem;
    MaskSaveAs4: TMenuItem;
    MaskCopy1: TMenuItem;
    N8: TMenuItem;
    MaskPopupMenu: TPopupMenu;
    MaskSaveAs: TMenuItem;
    MaskCopy: TMenuItem;
    StartUpTimer: TTimer;
    MainToolbarPanel: TPanel;
    ExitButton1: TSpeedButton;
    AboutButton1: TSpeedButton;
    NewButton1: TSpeedButton;
    OptionsButton1: TSpeedButton;
    Window1: TMenuItem;
    TileHorizontal1: TMenuItem;
    Cascade1: TMenuItem;
    TileVertical1: TMenuItem;
    ArrangeIcons1: TMenuItem;
    N9: TMenuItem;
    ShowEditorWindow1: TMenuItem;
    ShowTextureWindow1: TMenuItem;
    ShowPreviewWindow1: TMenuItem;
    ShowMaskWindow1: TMenuItem;
    SaveDialog2: TSaveDialog;
    Export1: TMenuItem;
    OpenDialog2: TOpenDialog;
    Import1: TMenuItem;
    PK3Button1: TSpeedButton;
    SavePK3Dialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure OpenGLPanelResize(Sender: TObject);
    procedure TexturePasteClick(Sender: TObject);
    procedure Copy3dButtonClick(Sender: TObject);
    procedure Save3dButtonClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure TextureCopyClick(Sender: TObject);
    procedure TextureOpenClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Model1Click(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure New1Click(Sender: TObject);
    procedure CodeEditorChange(Sender: TObject);
    procedure EditorSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OpenGLPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OpenGLPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLPanelDblClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Responder(const X, Y: Integer);
    procedure PaintBox2Responder(const X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditorSaveAsClick(Sender: TObject);
    procedure EditorCompileClick(Sender: TObject);
    procedure EditorOpenClick(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure PaintBoxViewFrontPaint(Sender: TObject);
    procedure PaintBoxViewTopPaint(Sender: TObject);
    procedure PaintBoxViewMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxViewMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxViewMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SaveTexture1Click(Sender: TObject);
    procedure MaskCopyClick(Sender: TObject);
    procedure MaskSaveAsClick(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StartUpTimerTimer(Sender: TObject);
    procedure TileHorizontal1Click(Sender: TObject);
    procedure TileVertical1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure ArrangeIcons1Click(Sender: TObject);
    procedure ShowEditorWindow1Click(Sender: TObject);
    procedure ShowPreviewWindow1Click(Sender: TObject);
    procedure ShowTextureWindow1Click(Sender: TObject);
    procedure ShowMaskWindow1Click(Sender: TObject);
    procedure MainToolbarPanelResize(Sender: TObject);
    procedure Window1Click(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure Import1Click(Sender: TObject);
    procedure PK3Button1Click(Sender: TObject);
  private
    { Private declarations }
    devparm: boolean;
    procedure Idle(Sender: TObject; var Done: Boolean);
    procedure Hint(Sender: TObject);
    procedure DoRenderGL2D;
    procedure DoRenderGL3D;
    procedure CreateGLTexture;
    procedure UpdateEnable;
    procedure Get3dPreviewBitmap(const b: TBitmap);
    procedure GetMaskTextureBitmap(const b: TBitmap);
    procedure InvalidatePaintBox;
    procedure TestImage;
    procedure CreateDrawBuffer;
    function CheckCanClose: boolean;
    procedure DoNewModel;
    procedure UpdateStatusBar;
    procedure ClearOutput;
    procedure Compile;
    procedure UpdateFrameListBox;
    procedure GLCalcFrame(const frm: integer);
    procedure DoSaveCodeEditor;
    procedure SetFileName(const fname: string);
    function DoOpenCodeEditor(const fname: string): boolean;
    function DoOpenDMXFile(const fname: string): boolean;
    procedure OnLoadCodeEditorFileMenuHistory(Sender: TObject; const fname: string);
    procedure EraseStigma2d(const pb: TPaintBox; const buf: TBitmap);
    procedure PaintStigma2d(const pb: TPaintBox);
    procedure ResetStigma3d;
    procedure UpdateStigma3d;
    procedure PaintStigma3d(const pb: TPaintBox);
    procedure PaintBoxViewResponder(Sender: TObject; const X, Y: integer);
    procedure CreateMaskBuffer;
    procedure StartUp;
  public
    { Public declarations }
    procedure SetCurrentFrame(const frm: integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  mdl_filemenuhistory,
  optionsfrm,
  SynUnicode,
  mdl_globals,
  mdl_utils,
  mdl_gl,
  mdl_defs,
  mdl_model,
  mdl_script_functions,
  mdl_pk3writer,
  frm_preview,
  frm_texture,
  frm_editor,
  frm_mask;

function CheckParam(const parm: string): integer;
var
  i: integer;
  uParm: string;
begin
  uParm := UpperCase(parm);
  for i := 1 to ParamCount do
    if UpperCase(ParamStr(i)) = uParm then
    begin
      Result := i;
      Exit;
    end;
  Result := -1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Scaled := False;
  globals.mdl := TDDModelLoader.Create;

  devparm := CheckParam('-devparm') > 0;
  PK3Button1.Visible := devparm;
  if not PK3Button1.Visible then
    AboutButton1.Left := PK3Button1.Left;

  DecimalSeparator := '.';

  globals.EditorFormCreated := False;
  globals.TextureFormCreated := False;
  globals.MaskFormCreated := False;
  globals.PreviewFormCreated := False;
  globals.Initialized := False;

  globals.hintcnt := 0;

  globals.filemenuhistory := TFileMenuHistory.Create(self);
  globals.filemenuhistory.MenuItem0 := FileMenuHistoryItem0;
  globals.filemenuhistory.MenuItem1 := FileMenuHistoryItem1;
  globals.filemenuhistory.MenuItem2 := FileMenuHistoryItem2;
  globals.filemenuhistory.MenuItem3 := FileMenuHistoryItem3;
  globals.filemenuhistory.MenuItem4 := FileMenuHistoryItem4;
  globals.filemenuhistory.MenuItem5 := FileMenuHistoryItem5;
  globals.filemenuhistory.MenuItem6 := FileMenuHistoryItem6;
  globals.filemenuhistory.MenuItem7 := FileMenuHistoryItem7;
  globals.filemenuhistory.MenuItem8 := FileMenuHistoryItem8;
  globals.filemenuhistory.MenuItem9 := FileMenuHistoryItem9;
  globals.filemenuhistory.OnOpen := OnLoadCodeEditorFileMenuHistory;

  mdl_LoadSettingFromFile(ChangeFileExt(ParamStr(0), '.ini'));

  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory9));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory8));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory7));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory6));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory5));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory4));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory3));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory2));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory1));
  globals.filemenuhistory.AddPath(bigstringtostring(@opt_filemenuhistory0));

  globals.mousedown1 := False;
  globals.mousedown2 := False;
  globals.stmousedown := False;

  globals.buffer := TBitmap.Create;
  globals.drawbuffer := TBitmap.Create;
  globals.maskbuffer := TBitmap.Create;
  globals.maskdrawbuffer := TBitmap.Create;

  globals.glpanx := 0;
  globals.glpany := 0;
  globals.glmousedown := 0;

  InitOpenGL;
  ReadExtensions;
  ReadImplementationProperties;

  StartUpTimer.Enabled := True;
end;

procedure TForm1.StartUp;
var
  pfd: TPIXELFORMATDESCRIPTOR;
  pf: Integer;
begin
  if globals.Initialized then
    Exit;

  // OpenGL initialisieren
  globals.dc := GetDC(PreviewForm.OpenGLPanel.Handle);

  // PixelFormat
  pfd.nSize := SizeOf(pfd);
  pfd.nVersion := 1;
  pfd.dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER or 0;
  pfd.iPixelType := PFD_TYPE_RGBA;      // PFD_TYPE_RGBA or PFD_TYPEINDEX
  pfd.cColorBits := 32;

  pf := ChoosePixelFormat(globals.dc, @pfd);   // Returns format that most closely matches above pixel format
  SetPixelFormat(globals.dc, pf, @pfd);

  globals.rc := wglCreateContext(globals.dc);    // Rendering Context = window-glCreateContext
  wglMakeCurrent(globals.dc, globals.rc);        // Make the DC (Form1) the rendering Context

  // Initialize GL environment variables

  glInit;
  ResetCamera;
  OpenGLPanelResize(nil);    // sets up the perspective

  TestImage;

  globals.gllist2d := glGenLists(1);
  globals.gllist3d := glGenLists(1);
  Application.OnIdle := Idle;
  Application.OnHint := Hint;

  DoNewModel;

  globals.Initialized := True;
end;

function stigma2Dx(const sx: single; const pb: TPaintBox): integer;
begin
  Result := GetIntInRange(Round(sx * pb.Width), 0, pb.Width);
end;

function stigma2Dy(const sy: single; const pb: TPaintBox): integer;
begin
  Result := GetIntInRange(Round(sy * pb.Height), 0, pb.Height);
end;


procedure TForm1.EraseStigma2d(const pb: TPaintBox; const buf: TBitmap);
var
  i: integer;
  stx, sty: integer;
begin
  stx := stigma2Dx(globals.stigma2d.x, pb);
  sty := stigma2Dy(globals.stigma2d.y, pb);

  pb.Canvas.Pixels[stx, sty] := buf.Canvas.Pixels[stx, sty];

  for i := 1 to 2 do
  begin
    pb.Canvas.Pixels[stx - i, sty] := buf.Canvas.Pixels[stx - i, sty];
    pb.Canvas.Pixels[stx + i, sty] := buf.Canvas.Pixels[stx + i, sty];
    pb.Canvas.Pixels[stx, sty + i] := buf.Canvas.Pixels[stx, sty + i];
    pb.Canvas.Pixels[stx, sty - i] := buf.Canvas.Pixels[stx, sty - i];
  end;
end;

procedure TForm1.PaintStigma2d(const pb: TPaintBox);
var
  i: integer;
  stx, sty: integer;
begin
  stx := stigma2Dx(globals.stigma2d.x, pb);
  sty := stigma2Dy(globals.stigma2d.y, pb);

  pb.Canvas.Pixels[stx, sty] := RGB(255, 255, 0);

  for i := 1 to 2 do
  begin
    pb.Canvas.Pixels[stx - i, sty] := RGB(255, 255, 0);
    pb.Canvas.Pixels[stx + i, sty] := RGB(255, 255, 0);
    pb.Canvas.Pixels[stx, sty + i] := RGB(255, 255, 0);
    pb.Canvas.Pixels[stx, sty - i] := RGB(255, 255, 0);
  end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  TextureForm.PaintBox1.Canvas.Draw(0, 0, globals.drawbuffer);
  PaintStigma2d(TextureForm.PaintBox1);
  PaintStigma2d(MaskForm.PaintBox2);
end;

procedure TForm1.OpenGLPanelResize(Sender: TObject);
begin
  glViewport(0, 0, PreviewForm.OpenGLPanel.Width, PreviewForm.OpenGLPanel.Height);
  glMatrixMode(GL_PROJECTION);
  glLoadMatrixF(@IdentityMatrix);
  InfinitePerspective(64.0, PreviewForm.OpenGLPanel.Width / PreviewForm.OpenGLPanel.Height, 0.01);
  glMatrixMode(GL_MODELVIEW);
  globals.glneedrecalc := True;
end;

procedure TForm1.Idle(Sender: TObject; var Done: Boolean);
var
  newglHorzPos, newglVertPos: integer;
begin
  newglHorzPos := PreviewForm.ScrollBox1.HorzScrollBar.Position;
  newglVertPos := PreviewForm.ScrollBox1.VertScrollBar.Position;
  if (newglHorzPos <> globals.lastglHorzPos) or (newglVertPos <> globals.lastglVertPos) then
  begin
    globals.lastglVertPos := newglVertPos;
    globals.lastglHorzPos := newglHorzPos;
    globals.glneedrefresh := True;
  end;

  if not globals.glneedrecalc then
    if not globals.glneedrefresh then
      Exit; // jval: We don't need to render :)

  DoRenderGL3D;

  Done := False;
  globals.glneedrecalc := False;
  globals.glneedrefresh := False;
end;

function stigma2glX(const ss: integer): GLfloat;
begin
  Result := ss / 32;
end;

function stigma2glY(const ss: integer): GLfloat;
begin
  Result := -ss / 32;
end;

function stigma2glZ(const ss: integer): GLfloat;
begin
  Result := ss / 32;
end;

procedure TForm1.DoRenderGL2D;
begin
  glViewport(0, 0, glGetTextureSize, glGetTextureSize);

  glBeginScene;

  glEnable2D;

  glEnable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, bitmaptexture);
  glColor3f(1.0, 1.0, 1.0);

  glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);

  glCallList(globals.gllist2d);

  glDisable2D;
end;

procedure TForm1.DoRenderGL3D;
begin
  glBeginScene;

  glRenderAxes;

  glEnable(GL_TEXTURE_2D);

  glBindTexture(GL_TEXTURE_2D, bitmaptexture);
  glColor3f(1.0, 1.0, 1.0);

  if opt_renderwireframe then
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
  else
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);

  glCallList(globals.gllist3d);

  if opt_renderstigma then
  begin
    glDisable(GL_TEXTURE_2D);
    glColor3f(1.0, 1.0, 0.0);
    glDrawSphere(stigma2glX(globals.stigma3d.x), stigma2glY(globals.stigma3d.y), stigma2glZ(globals.stigma3d.z), 0.05);
    glEnable(GL_TEXTURE_2D);
    glColor3f(1.0, 1.0, 1.0);
  end;

  glEndScene(globals.dc);
end;

procedure TForm1.UpdateEnable;
begin
  TextureForm.PasteTextureButton1.Enabled := Clipboard.HasFormat(CF_BITMAP);
  UpdateStatusBar;
end;

procedure TForm1.TexturePasteClick(Sender: TObject);
begin
  if Clipboard.HasFormat(CF_BITMAP) then
  begin
    globals.buffer.LoadFromClipboardFormat(CF_BITMAP, ClipBoard.GetAsHandle(cf_Bitmap), 0);
    CreateGLTexture;
    InvalidatePaintBox;
    globals.glneedrefresh := True;
  end;
end;

procedure TForm1.Hint(Sender: TObject);
begin
  if Application.Hint <> '' then
    globals.hintcnt := 8;
  StatusBar1.Panels[2].Text := Application.Hint;
end;

procedure TForm1.Copy3dButtonClick(Sender: TObject);
var
  b: TBitmap;
begin
  b := TBitmap.Create;
  try
    DoRenderGL3D; // JVAL: For some unknown reason this must be called before glReadPixels
    Get3dPreviewBitmap(b);
    Clipboard.Assign(b);
  finally
    b.Free;
  end;
end;

procedure TForm1.Save3dButtonClick(Sender: TObject);
var
  b: TBitmap;
begin
  if SavePictureDialog1.Execute then
  begin
    b := TBitmap.Create;
    try
      DoRenderGL3D; // JVAL: For some unknown reason this must be called before glReadPixels
      Get3dPreviewBitmap(b);
      BackupFile(SavePictureDialog1.FileName);
      b.SaveToFile(SavePictureDialog1.FileName);
    finally
      b.Free;
    end;
  end;
end;

procedure TForm1.Get3dPreviewBitmap(const b: TBitmap);
type
  long_a = array[0..$FFFF] of LongWord;
  Plong_a = ^long_a;
var
  L, buf: Plong_a;
  w, h: integer;
  i, j: integer;
  idx: integer;
begin
  w := PreviewForm.OpenGLPanel.Width;
  h := PreviewForm.OpenGLPanel.Height;
  b.Width := w;
  b.Height := h;
  b.PixelFormat := pf32bit;

  GetMem(L, w * h * SizeOf(LongWord));
  glReadPixels(0, 0, w, h, GL_BGRA, GL_UNSIGNED_BYTE, L);

  idx := 0;
  for j := 0 to h - 1 do
  begin
    buf := b.ScanLine[h - j - 1];
    for i := 0 to w - 1 do
    begin
      buf[i] := L[idx];
      Inc(idx);
    end;
  end;

  FreeMem(L, w * h * SizeOf(LongWord));
end;

procedure TForm1.GetMaskTextureBitmap(const b: TBitmap);
type
  long_a = array[0..$FFFF] of LongWord;
  Plong_a = ^long_a;
var
  L, buf: Plong_a;
  w, h: integer;
  i, j: integer;
  idx: integer;
begin
  w := glGetTextureSize;
  h := glGetTextureSize;
  b.Width := w;
  b.Height := h;
  b.PixelFormat := pf32bit;

  GetMem(L, w * h * SizeOf(LongWord));
  glReadPixels(0, 0, w, h, GL_BGRA, GL_UNSIGNED_BYTE, L);

  idx := 0;
  for j := 0 to h - 1 do
  begin
    buf := b.ScanLine[h - j - 1];
    for i := 0 to w - 1 do
    begin
      buf[i] := L[idx];
      Inc(idx);
    end;
  end;

  FreeMem(L, w * h * SizeOf(LongWord));
end;

resourcestring
  rsTitle = 'DelphiDOOM Procedural Modeler';

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageBox(
    Handle,
    PChar(Format('%s'#13#10'Version %s'#13#10#13#10'A tool for creating MODELS for the DelphiDOOM engine.'#13#10'© 2017-2021, jvalavanis@gmail.com', [rsTitle, I_VersionBuilt])),
    PChar(rsTitle),
    MB_OK or MB_ICONINFORMATION or MB_APPLMODAL);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.TextureCopyClick(Sender: TObject);
begin
  Clipboard.Assign(globals.buffer);
end;

procedure TForm1.TextureOpenClick(Sender: TObject);
var
  p: TPicture;
begin
  if OpenPictureDialog1.Execute then
  begin
    p := TPicture.Create;
    try
      p.LoadFromFile(OpenPictureDialog1.FileName);
      globals.buffer.PixelFormat := pf32bit;
      if p.Graphic.Width <> 0 then
      begin
        globals.buffer.Width := p.Graphic.Width;
        globals.buffer.Height := p.Graphic.Height;
        globals.buffer.Canvas.Draw(0, 0, p.Graphic)
      end
      else
      begin
        globals.buffer.Width := p.Bitmap.Width;
        globals.buffer.Height := p.Bitmap.Height;
        globals.buffer.Canvas.Draw(0, 0, p.Bitmap)
      end;
      CreateGLTexture;
    finally
      p.Free;
    end;
    InvalidatePaintBox;
    globals.glneedrecalc := True;
  end;
end;

procedure TForm1.InvalidatePaintBox;
begin
  TextureForm.PaintBox1.Width := globals.buffer.Width;
  TextureForm.PaintBox1.Height := globals.buffer.Height;
  CreateDrawBuffer;
  TextureForm.PaintBox1.Invalidate;
end;

procedure QSortGrays(const A: PIntegerArray; const Len: integer);

  function Gray(const i: Integer): Double;  { CCIR 601 grayscale}
  begin
    Result :=  GetRValue(i) * 0.2989 + GetGValue(i) * 0.5870 + GetBValue(i) * 0.1140;
  end;

  procedure qsortI(l, r: Integer);
  var
    i, j: integer;
    t: integer;
    d: double;
  begin
    repeat
      i := l;
      j := r;
      d := (Gray(A[l]) + Gray(A[r])) / 2;
      repeat
        while Gray(A[i]) < d do
          inc(i);
        while Gray(A[j]) > d do
          dec(j);
        if i <= j then
        begin
          t := A[i];
          A[i] := A[j];
          A[j] := t;
          inc(i);
          dec(j);
        end;
      until i > j;
      if l < j then
        qsortI(l, j);
      l := i;
    until i >= r;
  end;

begin
  if Len > 1 then
    qsortI(0, Len - 1);
end;


procedure TForm1.TestImage;
var
  idx, i, j: integer;
  A: array[0..63] of TColor;
  C: array[0..3] of byte;
  r, g, b: integer;
begin
  C[0] := 0;
  C[1] := 85;
  C[2] := 170;
  C[3] := 255;
  idx := 0;
  for b := 0 to 3 do
    for g := 0 to 3 do
      for r := 0 to 3 do
      begin
        A[idx] := RGB(C[r], C[g], C[b]);
        Inc(idx);
      end;
  QSortGrays(@A, 64);
  globals.buffer.Width := 256;
  globals.buffer.Height := 256;
  globals.buffer.PixelFormat := pf32bit;
  globals.buffer.Canvas.Pen.Style := psClear;
  globals.buffer.Canvas.Pen.Color := $0;
  globals.buffer.Canvas.Brush.Style := bsSolid;
  globals.buffer.Canvas.Brush.Color := 0;
  idx := 0;
  for j := 0 to 7 do
    for i := 0 to 7 do
    begin
      globals.buffer.Canvas.Brush.Color := A[idx];
      Inc(idx);
      globals.buffer.Canvas.FillRect(Rect(i * 32, j * 32, (i + 1) * 32, (j + 1) * 32));
    end;
  CreateGLTexture;
  InvalidatePaintBox;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  UpdateEnable;
  if globals.hintcnt > 0 then
    Dec(globals.hintcnt);
  if globals.hintcnt = 0 then
    Application.Hint := '';
end;

procedure TForm1.Model1Click(Sender: TObject);
begin
  PasteTexture1.Enabled := Clipboard.HasFormat(CF_BITMAP);
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  PaintBox1Responder(X, Y);
  globals.paintX := X;
  globals.paintY := Y;
end;

procedure TForm1.CreateGLTexture;
begin
  gld_CreateTexture(globals.buffer);
end;

procedure TForm1.CreateDrawBuffer;
begin
  globals.drawbuffer.Width := globals.buffer.Width;
  globals.drawbuffer.Height := globals.buffer.Height;

  globals.drawbuffer.Canvas.Draw(0, 0, globals.buffer);
end;

function TForm1.CheckCanClose: boolean;
var
  ret: integer;
begin
  if globals.changed then
  begin
    ret := MessageBox(Handle, 'Do you want to save changes?', PChar(rsTitle), MB_YESNOCANCEL or MB_ICONQUESTION or MB_APPLMODAL);
    if ret = idCancel then
    begin
      Result := False;
      exit;
    end;
    if ret = idNo then
    begin
      Result := True;
      exit;
    end;
    if ret = idYes then
    begin
      EditorSaveClick(self);
      Result := not globals.changed;
      exit;
    end;
  end;
  Result := True;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Application.OnIdle := nil;
  if CheckCanClose = False then
  begin
    CanClose := False;
    Application.OnIdle := Idle;
  end
  else
    CanClose := True;
end;

procedure TForm1.New1Click(Sender: TObject);
begin
  if not CheckCanClose then
    Exit;

  DoNewModel;
  ResetCamera;
end;

procedure TForm1.CodeEditorChange(Sender: TObject);
begin
  globals.changed := True;
end;

procedure TForm1.EditorSaveClick(Sender: TObject);
begin
  if globals.ffilename = '' then
  begin
    EditorSaveAsClick(Sender);
    Exit;
  end;
  DoSaveCodeEditor;
end;

const
  NEWMODELCODE =
    'model model1;'#13#10 +
    'begin'#13#10 +
    '  SetFrame(1);'#13#10 +
    '  glbegin(GL_QUADS);'#13#10 +
    '    glTexCoord2f(0,1); glVertex3f(-0.5,-0.5, 0);'#13#10 +
    '    glTexCoord2f(1,1); glVertex3f( 0.5,-0.5, 0);'#13#10 +
    '    glTexCoord2f(1,0); glVertex3f( 0.5, 0.5, 0);'#13#10 +
    '    glTexCoord2f(0,0); glVertex3f(-0.5, 0.5, 0);'#13#10 +
    '  glEnd;'#13#10 +
    '  SetFrame(0);'#13#10 +
    '  CallFrame(1);'#13#10 +
    'end.'#13#10;

procedure TForm1.DoNewModel;
begin
  globals.CodeEditor.Lines.Text := NEWMODELCODE;
  globals.changed := false;
  globals.glneedrecalc := True;
  SetFileName('');
  globals.paintX := 0;
  globals.paintY := 0;
  EditorForm.PageControl1.ActivePageIndex := 0;
  ClearOutput;
  ResetStigma3d;
  Compile;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glDeleteLists(globals.gllist2d, 1);
  glDeleteLists(globals.gllist3d, 1);
  gld_ShutDownTexture;
  globals.buffer.Free;
  globals.drawbuffer.Free;
  globals.maskbuffer.Free;
  globals.maskdrawbuffer.Free;
  globals.mdl.Free;
  gld_ShutDownTexture;
  wglMakeCurrent(0, 0);
  wglDeleteContext(globals.rc);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(0), @opt_filemenuhistory0);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(1), @opt_filemenuhistory1);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(2), @opt_filemenuhistory2);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(3), @opt_filemenuhistory3);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(4), @opt_filemenuhistory4);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(5), @opt_filemenuhistory5);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(6), @opt_filemenuhistory6);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(7), @opt_filemenuhistory7);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(8), @opt_filemenuhistory8);
  stringtobigstring(globals.filemenuhistory.PathStringIdx(9), @opt_filemenuhistory9);
  mdl_SaveSettingsToFile(ChangeFileExt(ParamStr(0), '.ini'));
  globals.filemenuhistory.Free;
end;

procedure TForm1.OpenGLPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button in [mbLeft, mbRight] then
  begin
    globals.glpanx := X;
    globals.glpany := Y;
    if Button = mbLeft then
      globals.glmousedown := 1
    else
      globals.glmousedown := 2;
  end;
end;

procedure TForm1.OpenGLPanelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  UpdateStatusBar;

  if globals.glmousedown = 0 then
    exit;

  if globals.glmousedown = 1 then
  begin
    camera.ay := camera.ay + (globals.glpanx - X);
    camera.ax := camera.ax + (globals.glpany - Y);
  end
  else
  begin
    camera.x := camera.x + (globals.glpanx - X) / PreviewForm.OpenGLPanel.Width * (camera.z - 1.0);
    if camera.x < -6.0 then
      camera.x := -6.0
    else if camera.x > 6.0 then
      camera.x := 6.0;

    camera.y := camera.y - (globals.glpany - Y) / PreviewForm.OpenGLPanel.Width * (camera.z - 1.0);
    if camera.y < -6.0 then
      camera.y := -6.0
    else if camera.y > 6.0 then
      camera.y := 6.0;
  end;

  globals.glneedrefresh := True;

  globals.glpanx := X;
  globals.glpany := Y;

  UpdateStatusBar;
end;

procedure TForm1.OpenGLPanelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  globals.glmousedown := 0;
  UpdateStatusBar;
end;

procedure TForm1.OpenGLPanelDblClick(Sender: TObject);
begin
  ResetCamera;
  globals.glneedrefresh := True;
end;

procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  pt: TPoint;
  r: TRect;
  z: glfloat;
begin
  if ActiveMDIChild = PreviewForm then
  begin
    pt := PreviewForm.OpenGLPanel.Parent.ScreenToClient(MousePos);
    r := PreviewForm.OpenGLPanel.ClientRect;
    if r.Right > PreviewForm.ScrollBox1.Width then
      r.Right := PreviewForm.ScrollBox1.Width;
    if r.Bottom > PreviewForm.ScrollBox1.Height then
      r.Bottom := PreviewForm.ScrollBox1.Height;
    if PtInRect(r, pt) then
    begin
      z := camera.z - 0.5;
      z := z / 0.99;
      camera.z := z + 0.5;
      if camera.z < -15.0 then
        camera.z := -15.0;
      globals.glneedrefresh := True;
      Handled := True;
    end;
  end;
end;

procedure TForm1.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  pt: TPoint;
  r: TRect;
  z: glfloat;
begin
  if ActiveMDIChild = PreviewForm then
  begin
    pt := PreviewForm.OpenGLPanel.Parent.ScreenToClient(MousePos);
    r := PreviewForm.OpenGLPanel.ClientRect;
    if r.Right > PreviewForm.ScrollBox1.Width then
      r.Right := PreviewForm.ScrollBox1.Width;
    if r.Bottom > PreviewForm.ScrollBox1.Height then
      r.Bottom := PreviewForm.ScrollBox1.Height;
    if PtInRect(r, pt) then
    begin
      z := camera.z - 0.5;
      z := z * 0.99;
      camera.z := z + 0.5;
      if camera.z > 0.5 then
        camera.z := 0.5;
      globals.glneedrefresh := True;
      Handled := True;
    end;
  end;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    globals.mousedown1 := True;
    PaintBox1Responder(X, Y);
  end;
end;

procedure TForm1.PaintBox1Responder(const X, Y: Integer);
begin
  if globals.mousedown1 then
  begin
    EraseStigma2d(TextureForm.PaintBox1, globals.buffer);
    EraseStigma2d(MaskForm.PaintBox2, globals.maskbuffer);
    globals.stigma2d.x := X / globals.drawbuffer.Width;
    globals.stigma2d.y := Y / globals.drawbuffer.Height;
    TextureForm.sPosEdit.Text := Format('%5.4f', [globals.stigma2d.x]);
    TextureForm.tPosEdit.Text := Format('%5.4f', [globals.stigma2d.y]);
    MaskForm.sPosEdit2.Text := Format('%5.4f', [globals.stigma2d.x]);
    MaskForm.tPosEdit2.Text := Format('%5.4f', [globals.stigma2d.y]);
    PaintStigma2d(TextureForm.PaintBox1);
    PaintStigma2d(MaskForm.PaintBox2);
  end;
  UpdateStatusBar;
end;

procedure TForm1.PaintBox2Responder(const X, Y: Integer);
begin
  if globals.mousedown2 then
  begin
    EraseStigma2d(TextureForm.PaintBox1, globals.buffer);
    EraseStigma2d(MaskForm.PaintBox2, globals.maskbuffer);
    globals.stigma2d.x := X / globals.maskdrawbuffer.Width;
    globals.stigma2d.y := Y / globals.maskdrawbuffer.Height;
    TextureForm.sPosEdit.Text := Format('%5.4f', [globals.stigma2d.x]);
    TextureForm.tPosEdit.Text := Format('%5.4f', [globals.stigma2d.y]);
    MaskForm.sPosEdit2.Text := Format('%5.4f', [globals.stigma2d.x]);
    MaskForm.tPosEdit2.Text := Format('%5.4f', [globals.stigma2d.y]);
    PaintStigma2d(TextureForm.PaintBox1);
    PaintStigma2d(MaskForm.PaintBox2);
  end;
  UpdateStatusBar;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  globals.mousedown1 := False;
end;

procedure TForm1.EditorSaveAsClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SetFileName(SaveDialog1.FileName);
    DoSaveCodeEditor;
  end;
end;

procedure TForm1.UpdateStatusBar;
begin
  StatusBar1.Panels[0].Text :=
    Format('(s=%5.4f) (t=%5.4f)', [globals.paintX / globals.drawbuffer.Width, globals.paintY / globals.drawbuffer.Height]);
  StatusBar1.Panels[1].Text :=
    Format('Camera(x=%2.2f, y=%2.2f, z=%2.2f)', [camera.x, camera.y, camera.z]);
end;

procedure TForm1.EditorCompileClick(Sender: TObject);
begin
  Compile;
end;

procedure TForm1.ClearOutput;
begin
  EditorForm.OutputMemo.Lines.Clear;
end;

procedure TForm1.Compile;
begin
  Screen.Cursor := crHourGlass;
  try
    ClearOutput;
    PreviewForm.AnimationTimer.Enabled := False;

    globals.mdl.LoadFromScript(globals.CodeEditor.Lines.Text);

    if globals.mdl.Frames.Count > 0 then
      GLCalcFrame(globals.mdl.Frames.Numbers[0])
    else
      GLCalcFrame(0);

    UpdateFrameListBox;

    globals.DecompilePascalMemo.Text := globals.mdl.Decompile(sl_pascal);
    globals.DecompileCLangMemo.Text := globals.mdl.Decompile(sl_clang);
    globals.glneedrecalc := True;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.UpdateFrameListBox;
var
  i: integer;
begin
  PreviewForm.FramesListBox.Items.Clear;
  for i := 0 to globals.mdl.Frames.Count - 1 do
    PreviewForm.FramesListBox.Items.Add('#' + IntToStr(globals.mdl.Frames.Numbers[i]));
  if PreviewForm.FramesListBox.Items.Count > 0 then
    PreviewForm.FramesListBox.ItemIndex := 0;
end;

procedure TForm1.GLCalcFrame(const frm: integer);
begin
  // 2d mask
  glDeleteLists(globals.gllist2d, 1);
  globals.gllist2d := glGenLists(1);

  glNewList(globals.gllist2d, GL_COMPILE);
  globals.mdl.RenderTextureMask(frm, glGetTextureSize, glGetTextureSize);
  glEndList;
  CreateMaskBuffer;
  MaskForm.PaintBox2.Invalidate;

  // 3d mesh
  glDeleteLists(globals.gllist3d, 1);
  globals.gllist3d := glGenLists(1);

  glNewList(globals.gllist3d, GL_COMPILE);
  globals.mdl.RenderFrame(frm);
  glEndList;
end;

procedure TForm1.DoSaveCodeEditor;
begin
  if globals.ffilename <> '' then
  begin
    globals.changed := false;
    BackupFile(globals.ffilename);
    globals.CodeEditor.Lines.SaveUnicode := False;
    globals.CodeEditor.Lines.SaveFormat := sfAnsi;
    globals.CodeEditor.Lines.SaveToFile(globals.ffilename);
    globals.filemenuhistory.AddPath(globals.ffilename);
  end;
end;

procedure TForm1.SetFileName(const fname: string);
begin
  globals.ffilename := fname;
  Caption := rsTitle;
  if globals.ffilename <> '' then
    EditorForm.Caption := 'Editor - ' + MkShortName(globals.ffilename);
end;

procedure TForm1.EditorOpenClick(Sender: TObject);
begin
  if not CheckCanClose then
    Exit;

  if OpenDialog1.Execute then
  begin
    DoOpenCodeEditor(OpenDialog1.FileName);
    ResetCamera;
  end;
end;

function TForm1.DoOpenCodeEditor(const fname: string): boolean;
begin
  if not FileExists(fname) then
  begin
    Result := False;
    Exit;
  end;

  globals.CodeEditor.Lines.LoadFromFile(fname);
  globals.filemenuhistory.AddPath(fname);

  globals.changed := false;
  globals.glneedrecalc := True;
  SetFileName(fname);
  globals.paintX := 0;
  globals.paintY := 0;
  EditorForm.PageControl1.ActivePageIndex := 0;
  ClearOutput;
  ResetStigma3d;
  Compile;
  Result := True;
end;

function TForm1.DoOpenDMXFile(const fname: string): boolean;
begin
  if not FileExists(fname) then
  begin
    Result := False;
    Exit;
  end;

  globals.changed := false;
  SetFileName('');
  globals.paintX := 0;
  globals.paintY := 0;
  EditorForm.PageControl1.ActivePageIndex := 0;
  ClearOutput;
  ResetStigma3d;

  globals.mdl.LoadFromFile(fname);

  if globals.mdl.Frames.Count > 0 then
    GLCalcFrame(globals.mdl.Frames.Numbers[0])
  else
    GLCalcFrame(0);

  UpdateFrameListBox;

  globals.CodeEditor.Text := globals.mdl.Decompile(sl_modelddscript);
  globals.DecompilePascalMemo.Text := globals.mdl.Decompile(sl_pascal);
  globals.DecompileCLangMemo.Text := globals.mdl.Decompile(sl_clang);
  globals.glneedrecalc := True;

  Result := True;
end;

procedure TForm1.OnLoadCodeEditorFileMenuHistory(Sender: TObject; const fname: string);
begin
  if not CheckCanClose then
    Exit;

  if not DoOpenCodeEditor(fname) then
  begin
    MessageBox(
      Handle,
      PChar(Format('%s'#13#10'File not found!', [fname])),
      PChar(rsTitle),
      MB_OK or MB_ICONWARNING or MB_APPLMODAL);
    Exit;
  end;

  ResetCamera;
end;

procedure TForm1.File1Click(Sender: TObject);
begin
  globals.filemenuhistory.RefreshMenuItems;
end;

procedure TForm1.Options1Click(Sender: TObject);
var
  f: TOptionsForm;
begin
  f := TOptionsForm.Create(nil);
  try
    f.ShowModal;
    if f.ModalResult = mrOK then
      globals.glneedrefresh := True;
  finally
    f.Free;
  end;
end;

procedure TForm1.ResetStigma3d;
begin
  globals.stigma3d.x := 0;
  globals.stigma3d.y := 0;
  globals.stigma3d.z := 0;
  PreviewForm.PaintBoxViewFront.Invalidate;
  PreviewForm.PaintBoxViewTop.Invalidate;
  UpdateStigma3d;
end;

procedure TForm1.PaintStigma3d(const pb: TPaintBox);
var
  sx, sy: integer;
  i: integer;
  txt: string;

  function stigma2pb(const ss: integer): integer;
  begin
    result := GetIntInRange(ss + 32, 0, 64);
  end;

begin
  if pb = PreviewForm.PaintBoxViewFront then
  begin
    sx := globals.stigma3d.x;
    sy := globals.stigma3d.y;
    txt := 'front';
  end
  else if pb = PreviewForm.PaintBoxViewTop then
  begin
    sx := globals.stigma3d.x;
    sy := globals.stigma3d.z;
    txt := 'top';
  end
  else
    Exit;

  pb.Canvas.Brush.Color := RGB(208, 208, 208);
  pb.Canvas.Pen.Color := RGB(255, 255, 255);
  pb.Canvas.Brush.Style := bsSolid;
  pb.Canvas.Pen.Style := psSolid;
  pb.Canvas.Pen.Width := 1;

  pb.Canvas.FillRect(Rect(0, 0, 65, 65));
  pb.Canvas.TextOut(0, 0, txt);

  pb.Canvas.Pen.Color := RGB(255, 255, 255);
  pb.Canvas.Brush.Style := bsClear;
  pb.Canvas.Pen.Style := psSolid;
  pb.Canvas.Pen.Width := 1;

  pb.Canvas.MoveTo(16, 16);
  pb.Canvas.LineTo(16, 48);
  pb.Canvas.LineTo(48, 48);
  pb.Canvas.LineTo(48, 16);
  pb.Canvas.LineTo(16, 16);

  pb.Canvas.Pen.Color := RGB(0, 0, 192);
  pb.Canvas.Brush.Style := bsClear;
  pb.Canvas.Pen.Style := psSolid;
  pb.Canvas.Pen.Width := 1;

  pb.Canvas.MoveTo(32, 0);
  pb.Canvas.LineTo(32, 64);

  pb.Canvas.MoveTo(0, 32);
  pb.Canvas.LineTo(64, 32);

  pb.Canvas.Pixels[stigma2pb(sx), stigma2pb(sy)] := RGB(255, 255, 0);

  for i := 1 to 2 do
  begin
    pb.Canvas.Pixels[stigma2pb(sx - i), stigma2pb(sy)] := RGB(255, 255, 0);
    pb.Canvas.Pixels[stigma2pb(sx + i), stigma2pb(sy)] := RGB(255, 255, 0);
    pb.Canvas.Pixels[stigma2pb(sx), stigma2pb(sy + i)] := RGB(255, 255, 0);
    pb.Canvas.Pixels[stigma2pb(sx), stigma2pb(sy - i)] := RGB(255, 255, 0);
  end;
end;

procedure TForm1.PaintBoxViewFrontPaint(Sender: TObject);
begin
  PaintStigma3d(PreviewForm.PaintBoxViewFront);
end;

procedure TForm1.PaintBoxViewTopPaint(Sender: TObject);
begin
  PaintStigma3d(PreviewForm.PaintBoxViewTop);
end;

procedure TForm1.PaintBoxViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    globals.stmousedown := True;
    PaintBoxViewResponder(Sender, X, Y);
  end;
end;

procedure TForm1.PaintBoxViewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  globals.stmousedown := False;
end;

procedure TForm1.PaintBoxViewResponder(Sender: TObject; const X, Y: integer);
begin
  if Sender = PreviewForm.PaintBoxViewFront then
  begin
    globals.stigma3d.x := GetIntInRange(X - 32, -32, 32);
    globals.stigma3d.y := GetIntInRange(Y - 32, -32, 32);
  end
  else if Sender = PreviewForm.PaintBoxViewTop then
  begin
    globals.stigma3d.x := GetIntInRange(X - 32, -32, 32);
    globals.stigma3d.z := GetIntInRange(Y - 32, -32, 32);
  end
  else
    Exit;

  PaintStigma3d(PreviewForm.PaintBoxViewFront);
  PaintStigma3d(PreviewForm.PaintBoxViewTop);
  globals.glneedrefresh := True;
  UpdateStigma3d;
end;

procedure TForm1.PaintBoxViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if globals.stmousedown then
    PaintBoxViewResponder(Sender, X, Y);
end;

procedure TForm1.UpdateStigma3d;
begin
  PreviewForm.xPosEdit.Text := Format('%5.4f', [stigma2glX(globals.stigma3d.x)]);
  PreviewForm.yPosEdit.Text := Format('%5.4f', [stigma2glY(globals.stigma3d.y)]);
  PreviewForm.zPosEdit.Text := Format('%5.4f', [stigma2glZ(globals.stigma3d.z)]);
end;

procedure TForm1.SaveTexture1Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    BackupFile(SavePictureDialog1.FileName);
    globals.buffer.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TForm1.MaskCopyClick(Sender: TObject);
var
  b: TBitmap;
begin
  b := TBitmap.Create;
  try
    DoRenderGL2D;
    GetMaskTextureBitmap(b);
    Clipboard.Assign(b);
    globals.glneedrefresh := True;
  finally
    b.Free;
  end;
end;

procedure TForm1.MaskSaveAsClick(Sender: TObject);
var
  b: TBitmap;
begin
  if SavePictureDialog1.Execute then
  begin
    b := TBitmap.Create;
    try
      DoRenderGL2D;
      GetMaskTextureBitmap(b);
      BackupFile(SavePictureDialog1.FileName);
      b.SaveToFile(SavePictureDialog1.FileName);
      globals.glneedrefresh := True;
    finally
      b.Free;
    end;
  end;
end;

procedure TForm1.CreateMaskBuffer;
begin
  DoRenderGL2D;
  GetMaskTextureBitmap(globals.maskbuffer);
  globals.maskdrawbuffer.Width := globals.maskbuffer.Width;
  globals.maskdrawbuffer.Height := globals.maskbuffer.Height;

  globals.maskdrawbuffer.Canvas.Draw(0, 0, globals.maskbuffer);
  globals.glneedrefresh := True;
end;

procedure TForm1.PaintBox2Paint(Sender: TObject);
begin
  MaskForm.PaintBox2.Width := globals.maskdrawbuffer.Width;
  MaskForm.PaintBox2.Height := globals.maskdrawbuffer.Height;
  MaskForm.PaintBox2.Canvas.Draw(0, 0, globals.maskdrawbuffer);
  PaintStigma2d(TextureForm.PaintBox1);
  PaintStigma2d(MaskForm.PaintBox2);
end;

procedure TForm1.PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    globals.mousedown2 := True;
    PaintBox2Responder(X, Y);
  end;
end;

procedure TForm1.PaintBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  PaintBox2Responder(X, Y);
  globals.paintX := X;
  globals.paintY := Y;
end;

procedure TForm1.PaintBox2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  globals.mousedown2 := False;
end;

procedure TForm1.StartUpTimerTimer(Sender: TObject);
begin
  if globals.EditorFormCreated then
    if globals.TextureFormCreated then
      if globals.MaskFormCreated then
        if globals.PreviewFormCreated then
        begin
          StartUp;
          StartUpTimer.Enabled := False;
        end;
end;

procedure TForm1.TileHorizontal1Click(Sender: TObject);
begin
  TileMode := tbHorizontal;
  Tile;
end;

procedure TForm1.TileVertical1Click(Sender: TObject);
begin
  TileMode := tbVertical;
  Tile;
end;

procedure TForm1.Cascade1Click(Sender: TObject);
begin
  Cascade;
end;

procedure TForm1.ArrangeIcons1Click(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TForm1.ShowEditorWindow1Click(Sender: TObject);
begin
  if EditorForm.WindowState = wsMinimized then
    EditorForm.WindowState := wsNormal;
  EditorForm.BringToFront;
end;

procedure TForm1.ShowPreviewWindow1Click(Sender: TObject);
begin
  if PreviewForm.WindowState = wsMinimized then
    PreviewForm.WindowState := wsNormal;
  PreviewForm.BringToFront;
end;

procedure TForm1.ShowTextureWindow1Click(Sender: TObject);
begin
  if TextureForm.WindowState = wsMinimized then
    TextureForm.WindowState := wsNormal;
  TextureForm.BringToFront;
end;

procedure TForm1.ShowMaskWindow1Click(Sender: TObject);
begin
  if MaskForm.WindowState = wsMinimized then
    MaskForm.WindowState := wsNormal;
  MaskForm.BringToFront;
end;

procedure TForm1.MainToolbarPanelResize(Sender: TObject);
begin
  ExitButton1.Left := MainToolbarPanel.Width - 40; 
end;

procedure TForm1.Window1Click(Sender: TObject);
begin
  ShowEditorWindow1.Checked := ActiveMDIChild = EditorForm;
  ShowPreviewWindow1.Checked := ActiveMDIChild = PreviewForm;
  ShowTextureWindow1.Checked := ActiveMDIChild = TextureForm;
  ShowMaskWindow1.Checked := ActiveMDIChild = MaskForm;
end;

procedure TForm1.SetCurrentFrame(const frm: integer);
begin
  GLCalcFrame(frm);
  globals.glneedrecalc := True;
end;

procedure TForm1.Export1Click(Sender: TObject);
begin
  if SaveDialog2.Execute then
    globals.mdl.SaveToFile(SaveDialog2.FileName);
end;

procedure TForm1.Import1Click(Sender: TObject);
begin
  if not CheckCanClose then
    Exit;

  if OpenDialog2.Execute then
  begin
    DoOpenDMXFile(OpenDialog2.FileName);
    ResetCamera;
  end;
end;

procedure TForm1.PK3Button1Click(Sender: TObject);
var
  b: TBitmap;
  b2: TBitmap;
  i: integer;
  sname: string;
  pk3: TPK3Writer;
  ms: TMemoryStream;
begin
  if not SavePK3Dialog.Execute then
    Exit;

  pk3 := TPK3Writer.Create;

  Screen.Cursor := crHourglass;
  try
    b2 := TBitmap.Create;
    b2.PixelFormat := pf24bit;
    b2.Width := 192;
    b2.Height := 254;
    if TEXTURESIZE = 1024 then
    begin
      b2.Width := b2.Width * 2;
      b2.Height := b2.Height * 2;
    end;
    for i := 0 to globals.mdl.Frames.Count - 1 do
    begin
      SetCurrentFrame(i);
      SetCurrentFrame(i);
      if i < 9 then
        sname := 'F00' + IntToStr(i + 1) + 'A0.bmp'
      else if i < 99 then
        sname := 'F0' + IntToStr(i + 1) + 'A0.bmp'
      else
        sname := 'F' + IntToStr(i + 1) + 'A0.bmp';

      b := TBitmap.Create;
      try
        DoRenderGL3D; // JVAL: For some unknown reason this must be called before glReadPixels
        glFinish;

        SetCurrentFrame(i);
        DoRenderGL3D; // JVAL: For some unknown reason this must be called before glReadPixels
        glFinish;

        SetCurrentFrame(i);
        DoRenderGL3D; // JVAL: For some unknown reason this must be called before glReadPixels
        glFinish;

        SetCurrentFrame(i);
        DoRenderGL3D; // JVAL: For some unknown reason this must be called before glReadPixels
        glFinish;

        SetCurrentFrame(i);
        DoRenderGL3D; // JVAL: For some unknown reason this must be called before glReadPixels
        glFinish;

        SetCurrentFrame(i);
        DoRenderGL3D; // JVAL: For some unknown reason this must be called before glReadPixels
        glFinish;

        InvalidatePaintBox;
        sleep(1);

        Get3dPreviewBitmap(b);
        if TEXTURESIZE = 1024 then
        begin
          b.Height := 512;
          b2.Canvas.CopyRect(Rect(0, 0, 2 * 192, 2 * 254), b.Canvas, Rect(2 * 160, 2 * 2, 2 * 352, 2 * 256));
        end
        else
        begin
          b.Height := 256;
          b2.Canvas.CopyRect(Rect(0, 0, 192, 254), b.Canvas, Rect(160, 2, 352, 256));
        end;

        ms := TMemoryStream.Create;
        b2.SaveToStream(ms);
        AddBinaryDataToPK3(pk3, sname, ms.Memory, ms.Size);
        ms.Free;
      finally
        b.Free;
      end;
    end;
    b2.Free;
    BackupFile(SavePK3Dialog.FileName);
    pk3.SaveToFile(SavePK3Dialog.FileName);
  finally
    Screen.Cursor := crDefault;
  end;
  pk3.Free;
end;

end.

