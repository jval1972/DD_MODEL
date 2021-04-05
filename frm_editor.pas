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
//  Script Editor Form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit frm_editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Menus,
  SynEdit, SynEditRegexSearch, SynEditSearch;

type
  TEditorForm = class(TForm)
    Panel8: TPanel;
    Splitter3: TSplitter;
    OutputMemo: TMemo;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FunctionsMainPanel: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    Panel6: TPanel;
    FunctionsListBox: TListBox;
    Splitter1: TSplitter;
    FunctionsEdit: TEdit;
    EditorPopupMenu: TPopupMenu;
    EditorCut1: TMenuItem;
    EditorCopy1: TMenuItem;
    EditorPaste1: TMenuItem;
    EditorUndo1: TMenuItem;
    EditorRedo1: TMenuItem;
    N1: TMenuItem;
    EditorSelectall1: TMenuItem;
    N2: TMenuItem;
    Search1: TMenuItem;
    Replace1: TMenuItem;
    SearchAgain1: TMenuItem;
    Gotolinenumber1: TMenuItem;
    DecompilePPopupMenu: TPopupMenu;
    DecompileCopy1: TMenuItem;
    DecompileSelectAll1: TMenuItem;
    MenuItem8: TMenuItem;
    DecompileGoToLine1: TMenuItem;
    DecompileSearch1: TMenuItem;
    DecompileSearchAgain1: TMenuItem;
    N3: TMenuItem;
    TabSheet3: TTabSheet;
    DecompileCPopupMenu: TPopupMenu;
    DecompileCopy2: TMenuItem;
    DecompileSelectAll2: TMenuItem;
    MenuItem3: TMenuItem;
    DecompileSearch2: TMenuItem;
    DecompileSearchAgain2: TMenuItem;
    MenuItem6: TMenuItem;
    DecompileGoToLine2: TMenuItem;
    EditorToolbarPanel: TPanel;
    SaveAsButton1: TSpeedButton;
    SaveButton1: TSpeedButton;
    OpenButton1: TSpeedButton;
    CompileButton1: TSpeedButton;
    Panel2: TPanel;
    SavePButton1: TSpeedButton;
    Panel7: TPanel;
    SaveCButton1: TSpeedButton;
    SaveDialogP: TSaveDialog;
    SaveDialogC: TSaveDialog;
    procedure Splitter3Moved(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveButton1Click(Sender: TObject);
    procedure SaveAsButton1Click(Sender: TObject);
    procedure CompileButton1Click(Sender: TObject);
    procedure OpenButton1Click(Sender: TObject);
    procedure Panel5Resize(Sender: TObject);
    procedure FunctionsListBoxClick(Sender: TObject);
    procedure EditorPopupMenuPopup(Sender: TObject);
    procedure EditorCut1Click(Sender: TObject);
    procedure EditorCopy1Click(Sender: TObject);
    procedure EditorPaste1Click(Sender: TObject);
    procedure EditorUndo1Click(Sender: TObject);
    procedure EditorRedo1Click(Sender: TObject);
    procedure EditorSelectall1Click(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure Replace1Click(Sender: TObject);
    procedure SearchAgain1Click(Sender: TObject);
    procedure Gotolinenumber1Click(Sender: TObject);
    procedure DecompilePPopupMenuPopup(Sender: TObject);
    procedure DecompileCopy1Click(Sender: TObject);
    procedure DecompileSelectAll1Click(Sender: TObject);
    procedure DecompileGoToLine1Click(Sender: TObject);
    procedure DecompileSearch1Click(Sender: TObject);
    procedure DecompileSearchAgain1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DecompileCopy2Click(Sender: TObject);
    procedure DecompileSelectAll2Click(Sender: TObject);
    procedure DecompileSearch2Click(Sender: TObject);
    procedure DecompileSearchAgain2Click(Sender: TObject);
    procedure DecompileGoToLine2Click(Sender: TObject);
    procedure DecompileCPopupMenuPopup(Sender: TObject);
    procedure SavePButton1Click(Sender: TObject);
    procedure SaveCButton1Click(Sender: TObject);
  private
    { Private declarations }
    SynEditRegexSearch1: TSynEditRegexSearch;
    SynEditSearch1: TSynEditSearch;
    procedure ShowSearchReplaceDialog(const SynEdit1: TSynEdit; AReplace: boolean);
    procedure DoSearchReplaceText(const SynEdit1: TSynEdit; AReplace: boolean; ABackwards: boolean);
    procedure ShowSearchDialog(const SynEdit1: TSynEdit);
    procedure SearchAgain(const SynEdit1: TSynEdit);
    procedure ShowReplaceDialog(const SynEdit1: TSynEdit);
    procedure GoToLineNumber(const SynEdit1: TSynEdit);
    procedure OnMoveMessage(var Msg: TWMMove); message WM_MOVE;
  public
    { Public declarations }
  end;

var
  EditorForm: TEditorForm;

implementation

{$R *.dfm}

uses
  main,
  mdl_utils,
  mdl_globals,
  mdl_script_functions,
  mdl_script_proclist,
  SynHighlighterDDModel,
  SynHighlighterDDDecompile,
  SynHighlighterCDecompile,
  SynEditTypes,
  SynUnicode,
  frm_ConfirmReplace,
  frm_GotoLine,
  frm_SearchText,
  frm_ReplaceText;

procedure outprocmemo(const s: string);
begin
  EditorForm.OutputMemo.Lines.Add(s);
end;

procedure TEditorForm.Splitter3Moved(Sender: TObject);
begin
  globals.glneedrefresh := True;
end;

procedure TEditorForm.FormCreate(Sender: TObject);
begin
  Scaled := False;

  globals.CodeEditor := TSynEdit.Create(Self);
  globals.CodeEditor.Parent := TabSheet1;
  globals.CodeEditor.Align := alClient;
  globals.CodeEditor.Highlighter := TSynDDModelHighlighter.Create(Self);
  globals.CodeEditor.OnChange := Form1.CodeEditorChange;
  globals.CodeEditor.Gutter.ShowLineNumbers := True;
  globals.CodeEditor.Gutter.AutoSize := True;
  globals.CodeEditor.MaxScrollWidth := 255;
  globals.CodeEditor.WantTabs := True;
  globals.CodeEditor.ReadOnly := False;
  globals.CodeEditor.OnMouseWheelDown := Form1.FormMouseWheelDown;
  globals.CodeEditor.OnMouseWheelUp := Form1.FormMouseWheelUp;
  globals.CodeEditor.PopupMenu := EditorPopupMenu;
  globals.CodeEditor.Lines.SaveUnicode := False;
  globals.CodeEditor.Lines.SaveFormat := sfAnsi;

  globals.DecompilePascalMemo := TSynEdit.Create(Self);
  globals.DecompilePascalMemo.Parent := TabSheet2;
  globals.DecompilePascalMemo.Align := alClient;
  globals.DecompilePascalMemo.Highlighter := TSynDDDecompileHightlighter.Create(Self);
  globals.DecompilePascalMemo.Gutter.ShowLineNumbers := True;
  globals.DecompilePascalMemo.Gutter.AutoSize := True;
  globals.DecompilePascalMemo.MaxScrollWidth := 255;
  globals.DecompilePascalMemo.WantTabs := True;
  globals.DecompilePascalMemo.ReadOnly := True;
  globals.DecompilePascalMemo.OnMouseWheelDown := Form1.FormMouseWheelDown;
  globals.DecompilePascalMemo.OnMouseWheelUp := Form1.FormMouseWheelUp;
  globals.DecompilePascalMemo.PopupMenu := DecompilePPopupMenu;
  globals.DecompilePascalMemo.Lines.SaveUnicode := False;
  globals.DecompilePascalMemo.Lines.SaveFormat := sfAnsi;

  globals.DecompileCLangMemo := TSynEdit.Create(Self);
  globals.DecompileCLangMemo.Parent := TabSheet3;
  globals.DecompileCLangMemo.Align := alClient;
  globals.DecompileCLangMemo.Highlighter := TSynCDecompileHightlighter.Create(Self);
  globals.DecompileCLangMemo.Gutter.ShowLineNumbers := True;
  globals.DecompileCLangMemo.Gutter.AutoSize := True;
  globals.DecompileCLangMemo.MaxScrollWidth := 255;
  globals.DecompileCLangMemo.WantTabs := True;
  globals.DecompileCLangMemo.ReadOnly := True;
  globals.DecompileCLangMemo.OnMouseWheelDown := Form1.FormMouseWheelDown;
  globals.DecompileCLangMemo.OnMouseWheelUp := Form1.FormMouseWheelUp;
  globals.DecompileCLangMemo.PopupMenu := DecompileCPopupMenu;
  globals.DecompileCLangMemo.Lines.SaveUnicode := False;
  globals.DecompileCLangMemo.Lines.SaveFormat := sfAnsi;

  SynEditRegexSearch1 := TSynEditRegexSearch.Create(Self);
  SynEditSearch1 := TSynEditSearch.Create(Self);
  
  PageControl1.ActivePageIndex := 0;

  @outproc := @outprocmemo;

  EditorToolbarPanel.PopupMenu := Form1.EditorPopupMenu;

  FunctionsListBox.Items.Text := MDL_Procs;
  if FunctionsListBox.Items.Count > 0 then
  begin
    FunctionsListBox.ItemIndex := 0;
    FunctionsEdit.Text := FunctionsListBox.Items.Strings[0];
  end;

  globals.EditorFormCreated := True;
end;

procedure TEditorForm.SaveButton1Click(Sender: TObject);
begin
  Form1.EditorSaveClick(Sender);
end;

procedure TEditorForm.SaveAsButton1Click(Sender: TObject);
begin
  Form1.EditorSaveAsClick(Sender);
end;

procedure TEditorForm.CompileButton1Click(Sender: TObject);
begin
  Form1.EditorCompileClick(Sender);
end;

procedure TEditorForm.OpenButton1Click(Sender: TObject);
begin
  Form1.EditorOpenClick(Sender);
end;

procedure TEditorForm.Panel5Resize(Sender: TObject);
begin
  if Panel5.Width > 8 then
    FunctionsEdit.Width := Panel5.Width - 8;
end;

procedure TEditorForm.FunctionsListBoxClick(Sender: TObject);
begin
  if FunctionsListBox.ItemIndex >= 0 then
    FunctionsEdit.Text := FunctionsListBox.Items.Strings[FunctionsListBox.ItemIndex];
end;

procedure TEditorForm.EditorPopupMenuPopup(Sender: TObject);
begin
  EditorUndo1.Enabled := globals.CodeEditor.CanUndo;
  EditorRedo1.Enabled := globals.CodeEditor.CanRedo;
  EditorCut1.Enabled := globals.CodeEditor.SelText <> '';
  EditorCopy1.Enabled := globals.CodeEditor.SelText <> '';
  EditorPaste1.Enabled := globals.CodeEditor.CanPaste;
end;

procedure TEditorForm.EditorCut1Click(Sender: TObject);
begin
  globals.CodeEditor.CutToClipboard;
end;

procedure TEditorForm.EditorCopy1Click(Sender: TObject);
begin
  globals.CodeEditor.CopyToClipboard;
end;

procedure TEditorForm.EditorPaste1Click(Sender: TObject);
begin
  globals.CodeEditor.PasteFromClipboard;
end;

procedure TEditorForm.EditorUndo1Click(Sender: TObject);
begin
  globals.CodeEditor.Undo;
end;

procedure TEditorForm.EditorRedo1Click(Sender: TObject);
begin
  globals.CodeEditor.Redo;
end;

procedure TEditorForm.EditorSelectall1Click(Sender: TObject);
begin
  globals.CodeEditor.SelectAll;
end;

var
  gbSearchBackwards: boolean;
  gbSearchCaseSensitive: boolean;
  gbSearchFromCaret: boolean;
  gbSearchSelectionOnly: boolean;
  gbSearchTextAtCaret: boolean;
  gbSearchWholeWords: boolean;
  gbSearchRegex: boolean;
  gsSearchText: string;
  gsSearchTextHistory: string;
  gsReplaceText: string;
  gsReplaceTextHistory: string;
  fSearchFromCaret: boolean;

procedure TEditorForm.ShowSearchReplaceDialog(const SynEdit1: TSynEdit; AReplace: boolean);
var
  dlg: TTextSearchDialog;
begin
  if AReplace then
    dlg := TTextReplaceDialog.Create(Self)
  else
    dlg := TTextSearchDialog.Create(Self);
  with dlg do
  try
    // assign search options
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    // start with last search text
    SearchText := gsSearchText;
    if gbSearchTextAtCaret then
    begin
      // if something is selected search for that text
      if SynEdit1.SelAvail and (SynEdit1.BlockBegin.Line = SynEdit1.BlockEnd.Line) //Birb (fix at SynEdit's SearchReplaceDemo)
      then
        SearchText := SynEdit1.SelText
      else
        SearchText := SynEdit1.GetWordAtRowCol(SynEdit1.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    if AReplace then with dlg as TTextReplaceDialog do
    begin
      ReplaceText := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end;
    SearchWholeWords := gbSearchWholeWords;
    if ShowModal = mrOK then
    begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gbSearchRegex := SearchRegularExpression;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      if AReplace then
        with dlg as TTextReplaceDialog do
        begin
          gsReplaceText := ReplaceText;
          gsReplaceTextHistory := ReplaceTextHistory;
        end;
      fSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then
      begin
        DoSearchReplaceText(SynEdit1, AReplace, gbSearchBackwards);
        fSearchFromCaret := True;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TEditorForm.DoSearchReplaceText(const SynEdit1: TSynEdit; AReplace: boolean; ABackwards: boolean);
var
  Options: TSynSearchOptions;
begin
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not fSearchFromCaret then
    Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
  if gbSearchRegex then
    SynEdit1.SearchEngine := SynEditRegexSearch1
  else
    SynEdit1.SearchEngine := SynEditSearch1;
  if SynEdit1.SearchReplace(gsSearchText, gsReplaceText, Options) = 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    if ssoBackwards in Options then
      SynEdit1.BlockEnd := SynEdit1.BlockBegin
    else
      SynEdit1.BlockBegin := SynEdit1.BlockEnd;
    SynEdit1.CaretXY := SynEdit1.BlockBegin;
  end;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

procedure TEditorForm.ShowSearchDialog(const SynEdit1: TSynEdit);
begin
  ShowSearchReplaceDialog(SynEdit1, False);
end;

procedure TEditorForm.SearchAgain(const SynEdit1: TSynEdit);
var
  Options: TSynSearchOptions;
begin
  if gsSearchText = '' then
  begin
    ShowSearchDialog(SynEdit1);
    Exit;
  end;

  Options := [];
  if gbSearchBackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
  if gbSearchRegex then
    SynEdit1.SearchEngine := SynEditRegexSearch1
  else
    SynEdit1.SearchEngine := SynEditSearch1;
  if SynEdit1.SearchReplace(gsSearchText, '', Options) = 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    if ssoBackwards in Options then
      SynEdit1.BlockEnd := SynEdit1.BlockBegin
    else
      SynEdit1.BlockBegin := SynEdit1.BlockEnd;
    SynEdit1.CaretXY := SynEdit1.BlockBegin;
  end;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

procedure TEditorForm.ShowReplaceDialog(const SynEdit1: TSynEdit);
begin
  ShowSearchReplaceDialog(SynEdit1, True);
end;

procedure TEditorForm.GoToLineNumber(const SynEdit1: TSynEdit);
begin
  with TfrmGotoLine.Create(self) do
  try
    Char := SynEdit1.CaretX;
    Line := SynEdit1.CaretY;
    ShowModal;
    if ModalResult = mrOK then
      SynEdit1.CaretXY := CaretXY;
  finally
    Free;
  end;
  try
    SynEdit1.SetFocus;
  except
  end;
end;

procedure TEditorForm.Search1Click(Sender: TObject);
begin
  ShowSearchDialog(globals.CodeEditor);
end;

procedure TEditorForm.Replace1Click(Sender: TObject);
begin
  ShowReplaceDialog(globals.CodeEditor);
end;

procedure TEditorForm.SearchAgain1Click(Sender: TObject);
begin
  SearchAgain(globals.CodeEditor);
end;

procedure TEditorForm.Gotolinenumber1Click(Sender: TObject);
begin
  GoToLineNumber(globals.CodeEditor);
end;

procedure TEditorForm.DecompilePPopupMenuPopup(Sender: TObject);
begin
  DecompileCopy1.Enabled := globals.DecompilePascalMemo.SelText <> '';
end;

procedure TEditorForm.DecompileCopy1Click(Sender: TObject);
begin
  globals.DecompilePascalMemo.CopyToClipboard;
end;

procedure TEditorForm.DecompileSelectAll1Click(Sender: TObject);
begin
  globals.DecompilePascalMemo.SelectAll;
end;

procedure TEditorForm.DecompileGoToLine1Click(Sender: TObject);
begin
  GoToLineNumber(globals.DecompilePascalMemo);
end;

procedure TEditorForm.DecompileSearch1Click(Sender: TObject);
begin
  ShowSearchDialog(globals.DecompilePascalMemo);
end;

procedure TEditorForm.DecompileSearchAgain1Click(Sender: TObject);
begin
  SearchAgain(globals.DecompilePascalMemo);
end;

procedure TEditorForm.OnMoveMessage(var Msg: TWMMove);
begin
  globals.glneedrefresh := True;
end;

procedure TEditorForm.FormResize(Sender: TObject);
begin
  globals.glneedrefresh := True;
end;

procedure TEditorForm.DecompileCopy2Click(Sender: TObject);
begin
  globals.DecompileCLangMemo.CopyToClipboard;
end;

procedure TEditorForm.DecompileSelectAll2Click(Sender: TObject);
begin
  globals.DecompileCLangMemo.SelectAll;
end;

procedure TEditorForm.DecompileSearch2Click(Sender: TObject);
begin
  ShowSearchDialog(globals.DecompileCLangMemo);
end;

procedure TEditorForm.DecompileSearchAgain2Click(Sender: TObject);
begin
  SearchAgain(globals.DecompileCLangMemo);
end;

procedure TEditorForm.DecompileGoToLine2Click(Sender: TObject);
begin
  GoToLineNumber(globals.DecompileCLangMemo);
end;

procedure TEditorForm.DecompileCPopupMenuPopup(Sender: TObject);
begin
  DecompileCopy2.Enabled := globals.DecompileCLangMemo.SelText <> '';
end;

procedure TEditorForm.SavePButton1Click(Sender: TObject);
begin
  if SaveDialogP.Execute then
  begin
    BackupFile(SaveDialogP.FileName);
    globals.DecompilePascalMemo.Lines.SaveUnicode := False;
    globals.DecompilePascalMemo.Lines.SaveFormat := sfAnsi;
    globals.DecompilePascalMemo.Lines.SaveToFile(SaveDialogP.FileName);
  end;
end;

procedure TEditorForm.SaveCButton1Click(Sender: TObject);
begin
  if SaveDialogC.Execute then
  begin
    BackupFile(SaveDialogC.FileName);
    globals.DecompileCLangMemo.Lines.SaveUnicode := False;
    globals.DecompileCLangMemo.Lines.SaveFormat := sfAnsi;
    globals.DecompileCLangMemo.Lines.SaveToFile(SaveDialogC.FileName);
  end;
end;

end.
