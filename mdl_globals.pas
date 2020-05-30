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
//  Global variables
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit mdl_globals;

interface

uses
  Windows, Graphics, dglOpenGL, mdl_filemenuhistory, SynEdit, mdl_model;

type
  globals_t = record
    mdl: TDDModelLoader;
    EditorFormCreated: boolean;
    TextureFormCreated: boolean;
    MaskFormCreated: boolean;
    PreviewFormCreated: boolean;
    Initialized: Boolean;
    glneedrecalc: boolean;
    glneedrefresh: boolean;
    changed: boolean;
    buffer: TBitmap;
    drawbuffer: TBitmap;
    maskbuffer: TBitmap;
    maskdrawbuffer: TBitmap;
    rc: HGLRC;   // Rendering Context
    dc: HDC;     // Device Context
    lastglHorzPos, lastglVertPos: integer;
    mousedown1: boolean;
    mousedown2: boolean;
    stmousedown: boolean;
    glmousedown: integer;
    gllist2d: GLUint;
    gllist3d: GLUint;
    glpanx, glpany: integer;
    ffilename: string;
    paintX: integer;
    paintY: integer;
    hintcnt: integer;
    filemenuhistory: TFileMenuHistory;
    CodeEditor: TSynEdit;
    DecompilePascalMemo: TSynEdit;
    DecompileCLangMemo: TSynEdit;
    stigma2d: record x, y: Single; end;
    stigma3d: record x, y, z: Integer; end;
  end;

var
  globals: globals_t;

implementation

initialization
  globals.EditorFormCreated := False;
  globals.TextureFormCreated := False;
  globals.MaskFormCreated := False;
  globals.PreviewFormCreated := False;
  globals.Initialized := False;

end.
