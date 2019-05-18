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
set t epslatex size @dissmarginwidth,7cm color colortext standalone header diss10pt.footnotesize
set output 'fig.tex'

# legend
unset key
# positioning
load 'positions.cfg'
SPACING_HORIZONTAL = 4
SPACING_VERTICAL = 2
OUTER_RATIO_L = 0.99
OUTER_RATIO_R = 0.5
OUTER_RATIO_T = 0.5
OUTER_RATIO_B = 0.99
# x-axis
set xrange [40:2000]
set xtics 10 offset 0,0.5
set xlabel offset 0,1.25
set logscale x
LABEL_X = '$f$ / Hz'
# y-axis
set yrange [-5:5]
set ytics 5 offset 0.5,0
set ylabel offset 2,0
set mytics 2
LABEL_Y = '$20 \lg |\sfpressure(\sfpos,\sfomega)|$'
# grid
load 'grid.cfg'
set grid mytics
# color scheme
load 'qualitative/Paired.plt'  # see gnuplot-colorbrewer
# axes
set format '$%g$'
set tics scale 0.75 out nomirror
# labels
load 'labels.cfg'
set label 1 at graph 0.0, 1.05 left front '\stepcounter{tmpcounter}(\alph{tmpcounter})'
set label 2 at graph 0.1, 1.05 left front
set label 3 at graph 0.43, 0.9 left front tc ls 2 '$\sfpos = [0,0,0]^{\mathrm T}$ m'
set label 4 at graph 0.43, 0.775 left front tc ls 4 '$\sfpos = [0.5,0,0]^{\mathrm T}$ m'
set label 5 at graph 0.43, 0.20 left front tc ls 6 '$\sfpos = [0,0.5,0]^{\mathrm T}$ m'
set label 6 at graph 0.43, 0.075  left front tc ls 8 '$\sfpos = [0,-0.5,0]^{\mathrm T}$ m'
# variables
sx = 1.0
sy = 0.5
orix1 = 0.0
oriy1 = 0.5
oriy2 = 0

################################################################################
set multiplot layout 2,1

#### plot 1 ####
# labels
set label 2 'without tapering'
# positioning
@pos_top_left
set size sx, sy
set origin orix1, oriy1
# plotting
plot 'P_x0.00_y0.00_tap0.txt' w l ls 2 lw 2,\
  'P_x0.50_y0.00_tap0.txt' w l ls 4 lw 2,\
  'P_x0.00_y0.50_tap0.txt' w l ls 6 lw 2,\
  'P_x0.00_y-0.50_tap0.txt' w l ls 8 lw 2

#### plot 2 ####
set label 2 'with tapering'
# positioning
@pos_bottom_left
set size sx, sy
set origin orix1, oriy2
# plotting
plot 'P_x0.00_y0.00_tap1.txt' w l ls 2 lw 2,\
  'P_x0.50_y0.00_tap1.txt' w l ls 4 lw 2,\
  'P_x0.00_y0.50_tap1.txt' w l ls 6 lw 2,\
  'P_x0.00_y-0.50_tap1.txt' w l ls 8 lw 2

################################################################################
unset multiplot

# output
call 'plot.plt' 'fig'
