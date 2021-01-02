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
//  Ini file
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit mdl_defs;

interface

function mdl_LoadSettingFromFile(const fn: string): boolean;

procedure mdl_SaveSettingsToFile(const fn: string);

const
  MAXHISTORYPATH = 2048;


type
  bigstring_t = array[0..MAXHISTORYPATH - 1] of char;
  bigstring_p = ^bigstring_t;

var
  opt_renderaxes: Boolean = True;
  opt_renderwireframe: Boolean = False;
  opt_renderstigma: Boolean = True;
  opt_filemenuhistory0: bigstring_t;
  opt_filemenuhistory1: bigstring_t;
  opt_filemenuhistory2: bigstring_t;
  opt_filemenuhistory3: bigstring_t;
  opt_filemenuhistory4: bigstring_t;
  opt_filemenuhistory5: bigstring_t;
  opt_filemenuhistory6: bigstring_t;
  opt_filemenuhistory7: bigstring_t;
  opt_filemenuhistory8: bigstring_t;
  opt_filemenuhistory9: bigstring_t;

function bigstringtostring(const bs: bigstring_p): string;
procedure stringtobigstring(const src: string; const bs: bigstring_p);

implementation

uses
  SysUtils, Classes;

const
  NUMSETTINGS = 13;

type
  TSettingsType = (tstInteger, tstBoolean, tstString);

  TSettingItem = record
    desc: string;
    typeof: TSettingsType;
    location: pointer;
  end;

var
  Settings: array[0..NUMSETTINGS - 1] of TSettingItem = (
   (desc: 'GL_RENDERAXES';
    typeof: tstBoolean;
    location: @opt_renderaxes;
   ),
   (desc: 'GL_RENDERWIREFRAME';
    typeof: tstBoolean;
    location: @opt_renderwireframe;
   ),
   (desc: 'GL_RENDERSTIGMA';
    typeof: tstBoolean;
    location: @opt_renderstigma;
   ),
    (
      desc: 'FILEMENUHISTORY0';
      typeof: tstString;
      location: @opt_filemenuhistory0;
    ),
    (
      desc: 'FILEMENUHISTORY1';
      typeof: tstString;
      location: @opt_filemenuhistory1;
    ),
    (
      desc: 'FILEMENUHISTORY2';
      typeof: tstString;
      location: @opt_filemenuhistory2;
    ),
    (
      desc: 'FILEMENUHISTORY3';
      typeof: tstString;
      location: @opt_filemenuhistory3;
    ),
    (
      desc: 'FILEMENUHISTORY4';
      typeof: tstString;
      location: @opt_filemenuhistory4;
    ),
    (
      desc: 'FILEMENUHISTORY5';
      typeof: tstString;
      location: @opt_filemenuhistory5;
    ),
    (
      desc: 'FILEMENUHISTORY6';
      typeof: tstString;
      location: @opt_filemenuhistory6;
    ),
    (
      desc: 'FILEMENUHISTORY7';
      typeof: tstString;
      location: @opt_filemenuhistory7;
    ),
    (
      desc: 'FILEMENUHISTORY8';
      typeof: tstString;
      location: @opt_filemenuhistory8;
    ),
    (
      desc: 'FILEMENUHISTORY9';
      typeof: tstString;
      location: @opt_filemenuhistory9;
    )
  );


procedure splitstring(const inp: string; var out1, out2: string; const splitter: string = ' ');
var
  p: integer;
begin
  p := Pos(splitter, inp);
  if p = 0 then
  begin
    out1 := inp;
    out2 := '';
  end
  else
  begin
    out1 := Trim(Copy(inp, 1, p - 1));
    out2 := Trim(Copy(inp, p + 1, Length(inp) - p));
  end;
end;

function IntToBool(const x: integer): boolean;
begin
  Result := x <> 0;
end;

function BoolToInt(const b: boolean): integer;
begin
  if b then
    Result := 1
  else
    Result := 0;
end;

function bigstringtostring(const bs: bigstring_p): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to MAXHISTORYPATH - 1 do
    if bs[i] = #0 then
      Exit
    else
      Result := Result + bs[i];
end;

procedure stringtobigstring(const src: string; const bs: bigstring_p);
var
  i: integer;
begin
  for i := 0 to MAXHISTORYPATH - 1 do
    bs[i] := #0;

  for i := 1 to Length(src) do
  begin
    bs[i - 1] := src[i];
    if i = MAXHISTORYPATH then
      Exit;
  end;
end;

procedure mdl_SaveSettingsToFile(const fn: string);
var
  s: TStringList;
  i: integer;
begin
  s := TStringList.Create;
  try
    for i := 0 to NUMSETTINGS - 1 do
    begin
      if Settings[i].typeof = tstInteger then
        s.Add(Format('%s=%d', [Settings[i].desc, PInteger(Settings[i].location)^]))
      else if Settings[i].typeof = tstBoolean then
        s.Add(Format('%s=%d', [Settings[i].desc, BoolToInt(PBoolean(Settings[i].location)^)]))
      else if Settings[i].typeof = tstString then
        s.Add(Format('%s=%s', [Settings[i].desc, bigstringtostring(bigstring_p(Settings[i].location))]))
    end;
    s.SaveToFile(fn);
  finally
    s.Free;
  end;
end;

function mdl_LoadSettingFromFile(const fn: string): boolean;
var
  s: TStringList;
  i, j: integer;
  s1, s2: string;
  itmp: integer;
begin
  if not FileExists(fn) then
  begin
    Result := False;
    exit;
  end;
  Result := True;
  s := TStringList.Create;
  try
    s.LoadFromFile(fn);
    begin
      for i := 0 to s.Count - 1 do
      begin
        splitstring(s.Strings[i], s1, s2, '=');
        if s2 <> '' then
        begin
          s1 := UpperCase(s1);
          for j := 0 to NUMSETTINGS - 1 do
            if UpperCase(Settings[j].desc) = s1 then
            begin
              if Settings[j].typeof = tstInteger then
              begin
                itmp := StrToIntDef(s2, PInteger(Settings[j].location)^);
                PInteger(Settings[j].location)^ := itmp;
              end
              else if Settings[j].typeof = tstBoolean then
              begin
                itmp := StrToIntDef(s2, BoolToInt(PBoolean(Settings[j].location)^));
                PBoolean(Settings[j].location)^ := IntToBool(itmp);
              end
              else if Settings[j].typeof = tstString then
              begin
                stringtobigstring(s2, bigstring_p(Settings[j].location));
              end;
            end;
        end;
      end;
    end;
  finally
    s.Free;
  end;

end;

end.

