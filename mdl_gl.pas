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
//  OpenGL Rendering
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom-procedural-modeler/
//------------------------------------------------------------------------------

unit mdl_gl;

interface

uses
  Windows,
  Graphics,
  dglOpenGL;

var
  gld_max_texturesize: integer = 0;
  gl_tex_format: integer = GL_RGBA8;
  gl_tex_filter: integer = GL_LINEAR;

procedure glInit;

procedure glBeginScene;

function glGetTextureSize: integer;

procedure glEndScene(dc: HDC);

procedure gld_CreateTexture(const b: TBitmap);
procedure gld_ShutDownTexture;

type
  TCDCamera = record
    x, y, z: glfloat;
    ax, ay, az: glfloat;
  end;

var
  camera: TCDCamera;

procedure ResetCamera;

procedure infinitePerspective(fovy: GLfloat; aspect: GLfloat; znear: GLfloat);

procedure glRenderAxes;

var
  bitmaptexture: GLuint = $FFFFFFFF;

const
  PiDiv360 = 0.008726646192;
  IdentityMatrix: array[0..15] of Single = (1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);

procedure glDrawSphere(const x, y, z: GLfloat; const radius: GLFloat);

procedure glEnable2D;

procedure glDisable2D;

implementation

uses
  Classes,
  Math,
  mdl_defs;

{------------------------------------------------------------------}
{  Initialise OpenGL                                               }
{------------------------------------------------------------------}
procedure glInit;
begin
  glClearColor(0.0, 0.0, 0.0, 0.0);   // Black Background
  glShadeModel(GL_SMOOTH);            // Enables Smooth Color Shading
  glClearDepth(1.0);                  // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST);            // Enable Depth Buffer
  glDepthFunc(GL_LESS);                // The Type Of Depth Test To Do
  glGetIntegerv(GL_MAX_TEXTURE_SIZE, @gld_max_texturesize);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  glEnable(GL_POINT_SMOOTH);
  glHint(GL_POINT_SMOOTH_HINT, GL_NICEST);
  glEnable(GL_LINE_SMOOTH);
  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
  glEnable(GL_POLYGON_SMOOTH);
  glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);
end;

procedure glBeginScene;
begin
  glLoadMatrixF(@IdentityMatrix);
  with Camera do
  begin
    glTranslatef(x, y, z);
    glRotatef(az, 0, 0, 1);
    glRotatef(ay, 0, -1, 0);
    glRotatef(ax, 1, 0, 0);
  end;
  glDisable(GL_CULL_FACE);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;

procedure glEndScene(dc: HDC);
begin
  SwapBuffers(dc); // Display the scene
end;

type
  PLongWordArray = ^TLongWordArray;
  TLongWordArray = array[0..$FFFF] of LongWord;

const
  TEXTURESIZE = 1024;

var
  actualltexsize: Integer = 0;

function glGetTextureSize: integer;
begin
  Result := actualltexsize;
end;

procedure gld_CreateTexture(const b: TBitmap);
var
  buffer: PLongWordArray;
  line: PLongWordArray;
  dest: PLongWord;
  tmp: TBitmap;
  i, j: integer;
  texsize: integer;
begin
  gld_ShutDownTexture;

  if gld_max_texturesize < TEXTURESIZE then
    texsize := gld_max_texturesize
  else
    texsize := TEXTURESIZE;

  actualltexsize := texsize;

  tmp := TBitmap.Create;
  tmp.Width := texsize;
  tmp.Height := texsize;
  tmp.PixelFormat := pf32bit;
  tmp.Canvas.StretchDraw(Rect(0, 0, texsize - 1, texsize - 1), b);

  GetMem(buffer, texsize * texsize * SizeOf(LongWord));
  dest := @buffer[0];

  for j := 0 to texsize - 1 do
  begin
    line := tmp.ScanLine[j];
    for i := 0 to texsize - 1 do
    begin
      dest^ := line[i];
      Inc(dest);
    end;
  end;
  tmp.Free;

  glGenTextures(1, @bitmaptexture);

  glBindTexture(GL_TEXTURE_2D, bitmaptexture);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8,
               texsize, texsize,
               0, GL_BGRA, GL_UNSIGNED_BYTE, buffer);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);

  FreeMem(buffer, texsize * texsize * SizeOf(LongWord));
end;


procedure gld_ShutDownTexture;
begin
  if bitmaptexture <> $FFFFFFFF then
    glDeleteTextures(1, @bitmaptexture);
end;

procedure ResetCamera;
begin
  camera.x := 0.0;
  camera.y := 0.0;
  camera.z := -3.0;
  camera.ax := 0.0;
  camera.ay := 0.0;
  camera.az := 0.0;
end;

procedure infinitePerspective(fovy: GLfloat; aspect: GLfloat; znear: GLfloat);
var
  left, right, bottom, top, RSubL, TSubB, TwoTimesZNear: GLfloat;
  M: array[0..15] of GLfloat;
begin
  top := znear * tan(fovy * PiDiv360);
  bottom := -top;
  left := bottom * aspect;
  right := top * aspect;
  RSubL := Right - Left;
  TSubB := Top - Bottom;
  TwoTimesZNear := 2 * ZNear;
  m[0] := TwoTimesZNear / RSubL;
  m[1] := 0;
  m[2] := 0;
  m[3] := 0;
  m[4] := 0;
  m[5] := TwoTimesZNear / TSubB;
  m[6] := 0;
  m[7] := 0;
  m[8] := (right + left) / RSubL;
  m[9] := (top + bottom) / TSubB;
  m[10] := -1;
  m[11] := -1;
  m[12] := 0;
  m[13] := 0;
  m[14] := -TwoTimesZNear;
  m[15] := 0;
  glMultMatrixF(@M);
end;

procedure glRenderAxes;
const
  DRUNIT = 0.5;
begin
  if opt_renderaxes then
  begin
    glDisable(GL_TEXTURE_2D);

    glColor3f(1.0, 1.0, 1.0);
    glBegin(GL_LINE_STRIP);
    glVertex3f(-DRUNIT, -DRUNIT, -DRUNIT);
    glVertex3f(-DRUNIT, DRUNIT, -DRUNIT);
    glVertex3f(DRUNIT, DRUNIT, -DRUNIT);
    glVertex3f(DRUNIT, -DRUNIT, -DRUNIT);
    glVertex3f(-DRUNIT, -DRUNIT, -DRUNIT);
    glEnd;

    glBegin(GL_LINE_STRIP);
    glVertex3f(-DRUNIT, -DRUNIT, DRUNIT);
    glVertex3f(-DRUNIT, DRUNIT, DRUNIT);
    glVertex3f(DRUNIT, DRUNIT, DRUNIT);
    glVertex3f(DRUNIT, -DRUNIT, DRUNIT);
    glVertex3f(-DRUNIT, -DRUNIT, DRUNIT);
    glEnd;

    glBegin(GL_LINE_STRIP);
    glVertex3f(-DRUNIT, -DRUNIT, -DRUNIT);
    glVertex3f(-DRUNIT, -DRUNIT, DRUNIT);
    glVertex3f(DRUNIT, -DRUNIT, DRUNIT);
    glVertex3f(DRUNIT, -DRUNIT, -DRUNIT);
    glVertex3f(-DRUNIT, -DRUNIT, -DRUNIT);
    glEnd;

    glBegin(GL_LINE_STRIP);
    glVertex3f(-DRUNIT, DRUNIT, -DRUNIT);
    glVertex3f(-DRUNIT, DRUNIT, DRUNIT);
    glVertex3f(DRUNIT, DRUNIT, DRUNIT);
    glVertex3f(DRUNIT, DRUNIT, -DRUNIT);
    glVertex3f(-DRUNIT, DRUNIT, -DRUNIT);
    glEnd;

    glBegin(GL_LINES);
    glVertex3f(0.0, 2 * DRUNIT, 0.0);
    glVertex3f(0.0, -2 * DRUNIT, 0.0);
    glVertex3f(2 * DRUNIT, 0.0, 0.0);
    glVertex3f(-2 * DRUNIT, 0.0, 0.0);
    glVertex3f(0.0, 0.0, 2 * DRUNIT);
    glVertex3f(0.0, 0.0, -2 * DRUNIT);
    glEnd;

    glEnable(GL_TEXTURE_2D);
  end;
end;

type
  vertex_t = record
    x, y, z: GLfloat;
    u, v: GLfloat;
  end;

// Bigger values = better accuracy
const
  NUMRINGS = 10;
  NUMSEGMENTS = 10;

procedure glDrawSphere(const x, y, z: GLfloat; const radius: GLFloat);
var
  A: array of vertex_t;
  ring, seg: integer;
  fDeltaRingAngle: GLfloat;
  fDeltaSegAngle: GLfloat;
  ss, sc: Extended;
  r0, r1: Extended;
  x0, x1: GLfloat;
  y0, y1: Extended;
  z0, z1: GLfloat;
  idx: integer;
  segNumSegmentsU: GLfloat;
begin
  SetLength(A, 2 * NUMRINGS * (NUMSEGMENTS + 1));
  fDeltaRingAngle := pi / NUMRINGS;
  fDeltaSegAngle  := 2 * pi / NUMSEGMENTS;

  idx := 0;

  // Generate the group of rings for the sphere
  for ring := 0 to NUMRINGS - 1 do
  begin
    SinCos(ring * fDeltaRingAngle, r0, y0);
    SinCos((ring + 1) * fDeltaRingAngle, r1, y1);

    // Generate the group of segments for the current ring
    for seg := 0 to NUMSEGMENTS do
    begin
      SinCos(seg * fDeltaSegAngle, ss, sc);
      x0 := r0 * ss;
      z0 := r0 * sc;
      x1 := r1 * ss;
      z1 := r1 * sc;

      segNumSegmentsU := 0.5 + seg / NUMSEGMENTS;

      A[idx].x := x0;
      A[idx].y := y0;
      A[idx].z := z0;
      A[idx].v := ring / NUMRINGS;
      A[idx].u := segNumSegmentsU;
      inc(idx);

      A[idx].x := x1;
      A[idx].y := y1;
      A[idx].z := z1;
      A[idx].v := (1 + ring) / NUMRINGS;
      A[idx].u := segNumSegmentsU;
      inc(idx);
    end;
  end;

  for idx := 0 to Length(A) - 1 do
  begin
    A[idx].x := (A[idx].x * radius) + x;
    A[idx].y := (A[idx].y * radius) + y;
    A[idx].z := (A[idx].z * radius) + z;
  end;

  glbegin(GL_TRIANGLE_STRIP);
  for idx := 0 to Length(A) - 1 do
  begin
    glTexCoord2f(A[idx].u, A[idx].v);
    glVertex3f(A[idx].x, A[idx].y, A[idx].z);
  end;
  glEnd;

  SetLength(A, 0);
end;

procedure glEnable2D;
var
  vPort: array[0..3] of GLInt;
begin
  glPushAttrib(GL_ALL_ATTRIB_BITS);

  glDisable(GL_CULL_FACE);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glGetIntegerv(GL_VIEWPORT, @vPort);

  glMatrixMode(GL_PROJECTION);
  glPushMatrix();
  glLoadIdentity();

  glOrtho(0, vPort[2], 0, vPort[3], -1, 1);
  glMatrixMode(GL_MODELVIEW);
  glPushMatrix();
  glLoadIdentity();
end;

procedure glDisable2D;
begin
  glMatrixMode(GL_PROJECTION);
  glPopMatrix();
  glMatrixMode(GL_MODELVIEW);
  glPopMatrix();
  glPopAttrib;
end;

end.
