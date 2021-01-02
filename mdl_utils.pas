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
//  Utility functions
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit mdl_utils;

interface

function MaxI(const a, b: Integer): Integer;

function MinI(const a, b: Integer): Integer;

function GetIntInRange(const x: Integer; const amin, amax: Integer): Integer;

type
  TString = class
    str: string;
    constructor Create(const astring: string);
  end;

function CopyFile(const sname, dname: string): boolean;

procedure BackupFile(const fname: string);

function MkShortName(const fname: string): string;

type
  TDNumberList = class
  private
    fList: PIntegerArray;
    fNumItems: integer;
  protected
    function Get(Index: Integer): integer; virtual;
    procedure Put(Index: Integer; const value: integer); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Add(const value: integer): integer; overload; virtual;
    procedure Add(const nlist: TDNumberList); overload; virtual;
    function Delete(const Index: integer): boolean;
    function IndexOf(const value: integer): integer;
    procedure Clear;
    procedure Sort;
    function Sum: integer;
    property Count: integer read fNumItems;
    property Numbers[Index: Integer]: integer read Get write Put; default;
    property List: PIntegerArray read fList;
  end;

procedure QSortIntegers(const A: PIntegerArray; const Len: integer);

function I_VersionBuilt(fname: string = ''): string;

implementation

uses
  Windows,
  SysUtils;

function MaxI(const a, b: Integer): Integer;
begin
  if a > b then
    Result := a
  else
    Result := b;
end;

function MinI(const a, b: Integer): Integer;
begin
  if a < b then
    Result := a
  else
    Result := b;
end;

function GetIntInRange(const x: Integer; const amin, amax: Integer): Integer;
begin
  Result := x;
  if Result < amin then
    Result := amin
  else if Result > amax then
    Result := amax;
end;

constructor TString.Create(const astring: string);
begin
  str := astring;
end;


function CopyFile(const sname, dname: string): boolean;
var
  FromF, ToF: file;
  NumRead, NumWritten: Integer;
  Buf: array[1..8192] of Char;
begin
  if FileExists(sname) then
  begin
    AssignFile(FromF, sname);
    Reset(FromF, 1);
    AssignFile(ToF, dname);
    Rewrite(ToF, 1);
    repeat
      BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
      BlockWrite(ToF, Buf, NumRead, NumWritten);
    until (NumRead = 0) or (NumWritten <> NumRead);
    CloseFile(FromF);
    CloseFile(ToF);
    Result := True;
  end
  else
    Result := False;
end;

procedure BackupFile(const fname: string);
var
  fbck: string;
begin
  if not FileExists(fname) then
    exit;
  fbck := fname + '_bak';
  CopyFile(fname, fbck);
end;

function MkShortName(const fname: string): string;
const
  MAXDISPFNAME = 30;
var
  i: integer;
begin
  if Length(fname) < MAXDISPFNAME then
  begin
    Result := fname;
    exit;
  end;
  Result := '';
  for i := Length(fname) downto Length(fname) - (MAXDISPFNAME - 6) do
    Result := fname[i] + Result;
  Result := '...' + Result;
  for i := 3 downto 1 do
    Result := fname[i] + Result;
end;

////////////////////////////////////////////////////////////////////////////////
// TDNumberList
constructor TDNumberList.Create;
begin
  fList := nil;
  fNumItems := 0;
end;

destructor TDNumberList.Destroy;
begin
  Clear;
end;

function TDNumberList.Get(Index: Integer): integer;
begin
  if (Index < 0) or (Index >= fNumItems) then
    result := 0
  else
    result := fList[Index];
end;

procedure TDNumberList.Put(Index: Integer; const value: integer);
begin
  fList[Index] := value;
end;

function TDNumberList.Add(const value: integer): integer;
begin
  ReallocMem(fList, (fNumItems + 1) * SizeOf(integer));
  Put(fNumItems, value);
  result := fNumItems;
  inc(fNumItems);
end;

procedure TDNumberList.Add(const nlist: TDNumberList);
var
  i: integer;
begin
  for i := 0 to nlist.Count - 1 do
    Add(nlist[i]);
end;

function TDNumberList.Delete(const Index: integer): boolean;
var
  i: integer;
begin
  if (Index < 0) or (Index >= fNumItems) then
  begin
    result := false;
    exit;
  end;

  for i := Index + 1 to fNumItems - 1 do
    fList[i - 1] := fList[i];

  ReallocMem(pointer(fList), (fNumItems - 1) * SizeOf(integer));
  dec(fNumItems);

  result := true;
end;

function TDNumberList.IndexOf(const value: integer): integer;
var
  i: integer;
begin
  for i := 0 to fNumItems - 1 do
    if fList[i] = value then
    begin
      result := i;
      exit;
    end;
  result := -1;
end;

procedure TDNumberList.Clear;
begin
  ReallocMem(pointer(fList), 0);
  fList := nil;
  fNumItems := 0;
end;

procedure TDNumberList.Sort;
begin
  QSortIntegers(fList, fNumItems);
end;

function TDNumberList.Sum: integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to fNumItems - 1 do
    result := result + fList[i];
end;

procedure QSortIntegers(const A: PIntegerArray; const Len: integer);

  procedure qsortI(l, r: Integer);
  var
    i, j: integer;
    t: integer;
    d: integer;
  begin
    repeat
      i := l;
      j := r;
      d := A[(l + r) shr 1];
      repeat
        while A[i] < d do
          inc(i);
        while A[j] > d do
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

function I_VersionBuilt(fname: string = ''): string;
var
  vsize: LongWord;
  zero: LongWord;
  buffer: PByteArray;
  res: pointer;
  len: LongWord;
  i: integer;
begin
  if fname = '' then
    fname := ParamStr(0);
  vsize := GetFileVersionInfoSize(PChar(fname), zero);
  if vsize = 0 then
  begin
    result := '';
    exit;
  end;

  GetMem(buffer, vsize + 1);
  GetFileVersionInfo(PChar(fname), 0, vsize, buffer);
  VerQueryValue(buffer, '\StringFileInfo\040904E4\FileVersion', res, len);
  result := '';
  for i := 0 to len - 1 do
  begin
    if PChar(res)^ = #0 then
      break;
    result := result + PChar(res)^;
    res := pointer(integer(res) + 1);
  end;
  FreeMem(pointer(buffer), vsize + 1);
end;

end.
