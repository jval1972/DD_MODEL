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
//  Texture Mask Form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit frm_mask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TMaskForm = class(TForm)
    ScrollBox3: TScrollBox;
    PaintBox2: TPaintBox;
    MaskToolbarPanel: TPanel;
    SaveMaskButton: TSpeedButton;
    CopyMaskButton: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    sPosEdit2: TEdit;
    tPosEdit2: TEdit;
    procedure SaveMaskButtonClick(Sender: TObject);
    procedure CopyMaskButtonClick(Sender: TObject);
    procedure PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox2Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnMoveMessage(var Msg: TWMMove); message WM_MOVE;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaskForm: TMaskForm;

implementation

{$R *.dfm}

uses
  main,
  mdl_globals;

procedure TMaskForm.SaveMaskButtonClick(Sender: TObject);
begin
  Form1.MaskSaveAsClick(Sender);
end;

procedure TMaskForm.CopyMaskButtonClick(Sender: TObject);
begin
  Form1.MaskCopyClick(Sender);
end;

procedure TMaskForm.PaintBox2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBox2MouseDown(Sender, Button, Shift, X, Y);
end;

procedure TMaskForm.PaintBox2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Form1.PaintBox2MouseMove(Sender, Shift, X, Y);
end;

procedure TMaskForm.PaintBox2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBox2MouseUp(Sender, Button, Shift, X, Y);
end;

procedure TMaskForm.PaintBox2Paint(Sender: TObject);
begin
  Form1.PaintBox2Paint(Sender);
end;

procedure TMaskForm.FormCreate(Sender: TObject);
begin
  Scaled := False;

  MaskToolbarPanel.PopupMenu := Form1.MaskPopupMenu;

  globals.MaskFormCreated := True;
end;

procedure TMaskForm.OnMoveMessage(var Msg: TWMMove);
begin
  globals.glneedrefresh := True;
end;

procedure TMaskForm.FormResize(Sender: TObject);
begin
  globals.glneedrefresh := True;
end;

end.
