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
//  Texture Form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit frm_texture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TTextureForm = class(TForm)
    TexturePanel: TPanel;
    TextureToolbarPanel: TPanel;
    OpenTextureButton1: TSpeedButton;
    PasteTextureButton1: TSpeedButton;
    CopyTextureButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    sPosEdit: TEdit;
    tPosEdit: TEdit;
    ScrollBox1: TScrollBox;
    PaintBox1: TPaintBox;
    procedure OpenTextureButton1Click(Sender: TObject);
    procedure CopyTextureButton1Click(Sender: TObject);
    procedure PasteTextureButton1Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnMoveMessage(var Msg: TWMMove); message WM_MOVE;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TextureForm: TTextureForm;

implementation

{$R *.dfm}

uses
  main,
  mdl_globals;

procedure TTextureForm.OpenTextureButton1Click(Sender: TObject);
begin
  Form1.TextureOpenClick(Sender);
end;

procedure TTextureForm.CopyTextureButton1Click(Sender: TObject);
begin
  Form1.TextureCopyClick(Sender);
end;

procedure TTextureForm.PasteTextureButton1Click(Sender: TObject);
begin
  Form1.TexturePasteClick(Sender);
end;

procedure TTextureForm.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBox1MouseDown(Sender, Button, Shift, X, Y);
end;

procedure TTextureForm.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.PaintBox1MouseMove(Sender, Shift, X, Y);
end;

procedure TTextureForm.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBox1MouseUp(Sender, Button, Shift, X, Y);
end;

procedure TTextureForm.PaintBox1Paint(Sender: TObject);
begin
  Form1.PaintBox1Paint(Sender);
end;

procedure TTextureForm.FormCreate(Sender: TObject);
begin
  Scaled := False;

  TextureToolbarPanel.PopupMenu := Form1.TexturePopupMenu;

  globals.TextureFormCreated := True;
end;

procedure TTextureForm.OnMoveMessage(var Msg: TWMMove);
begin
  globals.glneedrefresh := True;
end;

procedure TTextureForm.FormResize(Sender: TObject);
begin
  globals.glneedrefresh := True;
end;

end.
