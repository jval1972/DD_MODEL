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
//  Options form
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit optionsfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TOptionsForm = class(TForm)
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  mdl_defs;


procedure TOptionsForm.Button1Click(Sender: TObject);
begin
  opt_renderaxes := CheckBox2.Checked;
  opt_renderwireframe := CheckBox4.Checked;
  opt_renderstigma := CheckBox1.Checked;
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  Scaled := False;
  CheckBox2.Checked := opt_renderaxes;
  CheckBox4.Checked := opt_renderwireframe;
  CheckBox1.Checked := opt_renderstigma;
end;

end.
