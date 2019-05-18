#!/usr/bin/gnuplot

#*****************************************************************************
# Copyright (c) 2019      Fiete Winter                                       *
#                         Institut fuer Nachrichtentechnik                   *
#                         Universitaet Rostock                               *
#                         Richard-Wagner-Strasse 31, 18119 Rostock, Germany  *
#                                                                            *
# This file is part of the supplementary material for Fiete Winter's         *
# PhD thesis                                                                 *
#                                                                            *
# You can redistribute the material and/or modify it  under the terms of the *
# GNU  General  Public  License as published by the Free Software Foundation *
# , either version 3 of the License,  or (at your option) any later version. *
#                                                                            *
# This Material is distributed in the hope that it will be useful, but       *
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY *
# or FITNESS FOR A PARTICULAR PURPOSE.                                       *
# See the GNU General Public License for more details.                       *
#                                                                            *
# You should  have received a copy of the GNU General Public License along   *
# with this program. If not, see <http://www.gnu.org/licenses/>.             *
#                                                                            *
# http://github.com/fietew/phd-thesis                 fiete.winter@gmail.com *
#*****************************************************************************

# reset
set macros
set loadpath '../../gnuplot/'

load 'xyborder.cfg'
load 'array.cfg'
load 'standalone.cfg'

################################################################################
set t epslatex size @disstextwidth,7cm color colortext standalone header diss10pt.footnotesize
set output 'fig.tex'

# legend
unset key
# positioning
load 'positions.cfg'
# x-axis
set xrange [-1.5:1.5]
set xtics 1 offset 0,0.5
set xlabel offset 0,1.25
LABEL_X = '$x$ / m'
# y-axis
set yrange [-1.5:1.5]
set ytics 1 offset 0.5,0
set ylabel offset 2,0
LABEL_Y = '$y$ / m'
# c-axis
set cbtics offset -0.5,0
# colorbar
load 'colorbar.cfg'
unset colorbox
# axes
set size ratio -1
set format '$%g$'
set tics scale 0.75 out nomirror
# labels
load 'labels.cfg'
set label 1 at graph 0.15, 1.1 left front
set label 2 at graph 0.0, 1.1 left front '\stepcounter{tmpcounter}(\alph{tmpcounter})'
# variables
sx = 0.325
sy = 0.375
orix1 = 0.045
orix2 = 0.045 + 0.87*1*sx
orix3 = 0.045 + 0.87*2*sx
oriy1 = 0.55
oriy2 = 0.105

################################################################################
set multiplot layout 2,3

#### plot 1 ####
# positioning
@pos_top_left
set size sx, sy
set origin orix1, oriy1
# c-axis
load 'diverging/RdBu.plt'  # see gnuplot-colorbrewer
set palette negative
set cbrange [-1:1]
set cbtics 1
# labels
set label 1 'point source'
# plotting
plot 'Pps.dat' binary matrix with image,\
  'arrayps_active.txt' @array_continuous,\
  'arrayps_inactive.txt' @array_dashed,\
  'xref.txt' @array_virtual

#### plot 2 ####
# positioning
@pos_top
set size sx, sy
set origin orix2, oriy1
# labels
set label 1 'plane wave'
# plotting
plot 'Ppw.dat' binary matrix with image,\
  'arraypw_active.txt' @array_continuous,\
  'arraypw_inactive.txt' @array_dashed,\
  'xref.txt' @array_virtual

#### plot 3 ####
# positioning
@pos_top_right
set size sx, sy
set origin orix3, oriy1
# labels
set label 1 'focused point source'
# colorbar
set colorbox @colorbar_east
# plotting
plot 'Pfs.dat' binary matrix with image,\
  'arrayfs_active.txt' @array_continuous,\
  'arrayfs_inactive.txt' @array_dashed,\
  'xref.txt' @array_virtual

#### plot 4 ####
# positioning
@pos_bottom_left
set size sx, sy
set origin orix1, oriy2
# c-axis
load 'sequential/Reds.plt'  # see gnuplot-colorbrewer
set palette positive
set cbrange [-40:0]
set cbtics 10 add ('$0$ dB' 0)
# colorbar
unset colorbox
# labels
unset label 1
# positioning
@pos_bottom_left
# plotting
plot 'Pps_error.dat' binary matrix with image,\
  'arrayps_active.txt' @array_continuous,\
  'arrayps_inactive.txt' @array_dashed,\
  'xref.txt' @array_virtual

#### plot 5 ####
# positioning
@pos_bottom
set size sx, sy
set origin orix2, oriy2
# plotting
plot 'Ppw_error.dat' binary matrix with image,\
  'arraypw_active.txt' @array_continuous,\
  'arraypw_inactive.txt' @array_dashed,\
  'xref.txt' @array_virtual

#### plot 6 ####
# colorbar
set colorbox @colorbar_east
# positioning
@pos_bottom_right
set size sx, sy
set origin orix3, oriy2
# plotting
plot 'Pfs_error.dat' binary matrix with image,\
  'arrayfs_active.txt' @array_continuous,\
  'arrayfs_inactive.txt' @array_dashed,\
  'xref.txt' @array_virtual

################################################################################
unset multiplot

# output
call 'plot.plt' 'fig'
