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
//  Project file
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/?
//------------------------------------------------------------------------------

program DD_MODEL;

uses
  FastMM4 in 'FastMM4.pas',
  FastMM4Messages in 'FastMM4Messages.pas',
  Forms,
  dglOpenGL in 'dglOpenGL.pas',
  main in 'main.pas' {Form1},
  mdl_gl in 'mdl_gl.pas',
  mdl_utils in 'mdl_utils.pas',
  pngextra in 'pngextra.pas',
  pngimage in 'pngimage.pas',
  pnglang in 'pnglang.pas',
  xTGA in 'xTGA.pas',
  zBitmap in 'zBitmap.pas',
  zlibpas in 'zlibpas.pas',
  mdl_defs in 'mdl_defs.pas',
  mdl_script in 'mdl_script.pas',
  mdl_script_proclist in 'mdl_script_proclist.pas',
  mdl_script_functions in 'mdl_script_functions.pas',
  mdl_model in 'mdl_model.pas',
  uPSCompiler in 'uPSCompiler.pas',
  uPSRuntime in 'uPSRuntime.pas',
  uPSUtils in 'uPSUtils.pas',
  mdl_filemenuhistory in 'mdl_filemenuhistory.pas',
  SynEdit in 'SynEdit\SynEdit.pas',
  SynEditKbdHandler in 'SynEdit\SynEditKbdHandler.pas',
  SynEditKeyCmds in 'SynEdit\SynEditKeyCmds.pas',
  SynEditKeyConst in 'SynEdit\SynEditKeyConst.pas',
  SynEditMiscClasses in 'SynEdit\SynEditMiscClasses.pas',
  SynEditMiscProcs in 'SynEdit\SynEditMiscProcs.pas',
  SynEditTextBuffer in 'SynEdit\SynEditTextBuffer.pas',
  SynEditTypes in 'SynEdit\SynEditTypes.pas',
  SynUnicode in 'SynEdit\SynUnicode.pas',
  SynEditHighlighter in 'SynEdit\SynEditHighlighter.pas',
  SynEditHighlighterOptions in 'SynEdit\SynEditHighlighterOptions.pas',
  SynHighlighterMulti in 'SynEdit\SynHighlighterMulti.pas',
  SynRegExpr in 'SynEdit\SynRegExpr.pas',
  SynEditStrConst in 'SynEdit\SynEditStrConst.pas',
  SynTextDrawer in 'SynEdit\SynTextDrawer.pas',
  SynEditWordWrap in 'SynEdit\SynEditWordWrap.pas',
  SynHighlighterDDModel in 'SynEdit\SynHighlighterDDModel.pas',
  optionsfrm in 'optionsfrm.pas' {OptionsForm},
  frm_editor in 'frm_editor.pas' {EditorForm},
  mdl_globals in 'mdl_globals.pas',
  frm_texture in 'frm_texture.pas' {TextureForm},
  frm_mask in 'frm_mask.pas' {MaskForm},
  frm_preview in 'frm_preview.pas' {PreviewForm},
  SynHighlighterDDDecompile in 'SynEdit\SynHighlighterDDDecompile.pas',
  frm_ConfirmReplace in 'frm_ConfirmReplace.pas' {ConfirmReplaceDialog},
  frm_GotoLine in 'frm_GotoLine.pas' {frmGotoLine},
  frm_SearchText in 'frm_SearchText.pas' {TextSearchDialog},
  frm_ReplaceText in 'frm_ReplaceText.pas' {TextReplaceDialog},
  SynEditRegexSearch in 'SynEdit\SynEditRegexSearch.pas',
  SynEditSearch in 'SynEdit\SynEditSearch.pas',
  SynHighlighterCDecompile in 'SynEdit\SynHighlighterCDecompile.pas';

{$R *.res}

var
  Saved8087CW: Word;

begin
  { Save the current FPU state and then disable FPU exceptions }
  Saved8087CW := Default8087CW;
  Set8087CW($133f); { Disable all fpu exceptions }

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMaskForm, MaskForm);
  Application.CreateForm(TTextureForm, TextureForm);
  Application.CreateForm(TPreviewForm, PreviewForm);
  Application.CreateForm(TEditorForm, EditorForm);
  Application.CreateForm(TConfirmReplaceDialog, ConfirmReplaceDialog);
  Application.Run;

  { Reset the FPU to the previous state }
  Set8087CW(Saved8087CW);
end.
