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
//  3D preview Form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit frm_preview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TPreviewForm = class(TForm)
    Panel1: TPanel;
    PreviewToolbarPanel: TPanel;
    Copy3dButton: TSpeedButton;
    Save3dButton: TSpeedButton;
    PaintBoxViewFront: TPaintBox;
    PaintBoxViewTop: TPaintBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    xPosEdit: TEdit;
    yPosEdit: TEdit;
    zPosEdit: TEdit;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    OpenGLPanel: TPanel;
    FramesListBox: TListBox;
    Label1: TLabel;
    EditorToolbarPanel: TPanel;
    PrevFrameButton: TSpeedButton;
    NextFrameButton: TSpeedButton;
    PlayAnimationButton: TSpeedButton;
    StopAnimationButton: TSpeedButton;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    AnimationTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure OpenGLPanelDblClick(Sender: TObject);
    procedure OpenGLPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OpenGLPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLPanelResize(Sender: TObject);
    procedure Copy3dButtonClick(Sender: TObject);
    procedure Save3dButtonClick(Sender: TObject);
    procedure PaintBoxViewFrontMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxViewFrontMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxViewFrontMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxViewFrontPaint(Sender: TObject);
    procedure PaintBoxViewTopMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxViewTopMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure PaintBoxViewTopMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxViewTopPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure PrevFrameButtonClick(Sender: TObject);
    procedure NextFrameButtonClick(Sender: TObject);
    procedure FramesListBoxClick(Sender: TObject);
    procedure PlayAnimationButtonClick(Sender: TObject);
    procedure StopAnimationButtonClick(Sender: TObject);
    procedure AnimationTimerTimer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure UpdateFrameFromListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PreviewForm: TPreviewForm;

implementation

{$R *.dfm}

uses
  main,
  mdl_globals,
  mdl_utils;

procedure TPreviewForm.FormCreate(Sender: TObject);
begin
  Scaled := False;

  PreviewToolbarPanel.PopupMenu := Form1.PreviewPopupMenu;
  TrackBar1Change(Sender);

  globals.PreviewFormCreated := True;
end;

procedure TPreviewForm.OpenGLPanelDblClick(Sender: TObject);
begin
  Form1.OpenGLPanelDblClick(Sender);
end;

procedure TPreviewForm.OpenGLPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.OpenGLPanelMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TPreviewForm.OpenGLPanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.OpenGLPanelMouseMove(Sender, Shift, X, Y);
end;

procedure TPreviewForm.OpenGLPanelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.OpenGLPanelMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TPreviewForm.OpenGLPanelResize(Sender: TObject);
begin
  Form1.OpenGLPanelResize(Sender);
end;

procedure TPreviewForm.Copy3dButtonClick(Sender: TObject);
begin
  Form1.Copy3dButtonClick(Sender);
end;

procedure TPreviewForm.Save3dButtonClick(Sender: TObject);
begin
  Form1.Save3dButtonClick(Sender);
end;

procedure TPreviewForm.PaintBoxViewFrontMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBoxViewMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TPreviewForm.PaintBoxViewFrontMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBoxViewMouseMove(Sender, Shift, X, Y);
end;

procedure TPreviewForm.PaintBoxViewFrontMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBoxViewMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TPreviewForm.PaintBoxViewFrontPaint(Sender: TObject);
begin
  Form1.PaintBoxViewFrontPaint(Sender);
end;

procedure TPreviewForm.PaintBoxViewTopMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBoxViewMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TPreviewForm.PaintBoxViewTopMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBoxViewMouseMove(Sender, Shift, X, Y);
end;

procedure TPreviewForm.PaintBoxViewTopMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.PaintBoxViewMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TPreviewForm.PaintBoxViewTopPaint(Sender: TObject);
begin
  Form1.PaintBoxViewTopPaint(Sender);
end;

procedure TPreviewForm.FormActivate(Sender: TObject);
begin
  globals.glneedrefresh := True;
end;

procedure TPreviewForm.FormResize(Sender: TObject);
begin
  globals.glneedrefresh := True;
end;

procedure TPreviewForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  globals.glneedrefresh := True;
end;

procedure TPreviewForm.PrevFrameButtonClick(Sender: TObject);
var
  frm: integer;
begin
  frm := FramesListBox.ItemIndex;
  if frm < 0 then
    frm := 0
  else if frm = 0 then
    frm := FramesListBox.Items.Count - 1
  else
    frm := frm - 1;
  if frm >= FramesListBox.Items.Count then
    frm := FramesListBox.Items.Count - 1
  else if frm < 0 then
    frm := 0;
  FramesListBox.ItemIndex := frm;
  UpdateFrameFromListBox;
end;

procedure TPreviewForm.NextFrameButtonClick(Sender: TObject);
var
  frm: integer;
begin
  frm := FramesListBox.ItemIndex;
  if frm < 0 then
    frm := 0
  else if frm >= FramesListBox.Items.Count - 1 then
    frm := 0
  else
    frm := frm + 1;
  if frm >= FramesListBox.Items.Count then
    frm := FramesListBox.Items.Count - 1
  else if frm < 0 then
    frm := 0;
  FramesListBox.ItemIndex := frm;
  UpdateFrameFromListBox;
end;

procedure TPreviewForm.FramesListBoxClick(Sender: TObject);
begin
  UpdateFrameFromListBox;
end;

procedure TPreviewForm.PlayAnimationButtonClick(Sender: TObject);
begin
  AnimationTimer.Enabled := True;
end;

procedure TPreviewForm.StopAnimationButtonClick(Sender: TObject);
begin
  AnimationTimer.Enabled := False;
end;

procedure TPreviewForm.AnimationTimerTimer(Sender: TObject);
begin
  NextFrameButtonClick(Sender);
end;

procedure TPreviewForm.TrackBar1Change(Sender: TObject);
begin
  AnimationTimer.Interval := (10 + TrackBar1.Max - TrackBar1.Position) * 5;
end;

procedure TPreviewForm.UpdateFrameFromListBox;
begin
  if globals.mdl.Frames.Count > 0 then
    Form1.SetCurrentFrame(globals.mdl.Frames.Numbers[GetIntInRange(FramesListBox.ItemIndex, 0, globals.mdl.Frames.Count - 1)])
  else
    Form1.SetCurrentFrame(0);
end;

end.
