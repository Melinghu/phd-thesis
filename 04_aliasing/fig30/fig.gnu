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
set t epslatex size @dissfullwidth,7.2cm color colortext standalone header diss10pt.footnotesize
set output 'fig.tex'

# legend
unset key
# positioning
load 'positions.cfg'
# x-axis
set xrange [-1.5:1.5]
set xtics 1 offset 0,0.5
set xlabel offset 0,1.2
LABEL_X = '$x$ / m'
# y-axis
set yrange [-1.5:1.5]
set ytics 1 offset 0.5,0
set ylabel offset 2.5,0
LABEL_Y = '$y$ / m'
# c-axis
set cbtics offset -0.5,0
# colorbar
load 'colorbar.cfg'
# axes
set size ratio -1
set tics scale 0.75 out nomirror
# style
set style line 101 lc rgb 'black' lw 4
set style line 102 lc rgb 'black' lw 4 pt 2
# labels
load 'labels.cfg'
set label 1 at graph 0.0, 1.07 left front '\stepcounter{tmpcounter}(\alph{tmpcounter})'
set label 3 at graph 0.5, 1.07 center front
# variables
sx = 0.21
sy = 0.385
orix1 = 0.025 + 0*0.86*sx
orix2 = 0.025 + 1*0.86*sx
orix3 = 0.025 + 2*0.86*sx
orix4 = 0.025 + 3*0.86*sx
orix5 = 0.025 + 4*0.86*sx
oriy1 = 0.1 + 1*1.19*sy
oriy2 = 0.1 + 0*1.19*sy
Rcvec = '0.2 0.4 0.6 0.8 1.0'
# functions
db(x) = 20*log10(x)
Rclabel = 'sprintf(''$\sfRlocal = %2.2f$~m'', Rc)'

################################################################################
set multiplot layout 1,5

set view map
unset surface
set contour base
# set cntrlabel format '%8.3g' font ',7' start 0 interval 1000
# set cntrparam order 4
# set cntrparam points 5
# set cntrparam bspline
set format '%g'
do for [ii=1:words(Rcvec)] {
  Rc = word(Rcvec, ii)+0.0
  set cntrparam level incremental 2.5, 1, 2.5
  set table sprintf('cont_fS_Rc%2.2f.txt', Rc)
  splot sprintf('fS_Rc%2.2f.dat', Rc) u 1:2:($3/1000) binary matrix w l
  unset table
}

#### plot 1 ####
# c-axis
set cbrange [-1:1]
set cbtics 1
# palette
set palette negative
set palette maxcolor 0
load 'diverging/RdBu.plt'  # see gnuplot-colorbrewer
# colorbar
unset colorbox
# positioning
set size sx, sy
set origin orix1, oriy1
@pos_top_left
# variables
Rc = word(Rcvec, 1)+0
window = 'max-rE'
# labels
set label 3 @Rclabel
# plotting
load 'plotP.gnu'

#### plot 2 ####
# positioning
set size sx, sy
set origin orix2, oriy1
@pos_top
# variables
Rc = word(Rcvec, 2)+0
# labels
set label 3 @Rclabel
# plotting
load 'plotP.gnu'

#### plot 3 ####
# positioning
set size sx, sy
set origin orix3, oriy1
@pos_top
# variables
Rc = word(Rcvec, 3)+0
# labels
set label 3 @Rclabel
# plotting
load 'plotP.gnu'

#### plot 4 ####
# positioning
set size sx, sy
set origin orix4, oriy1
@pos_top
# variables
Rc = word(Rcvec, 4)+0
# labels
set label 3 @Rclabel
# plotting
load 'plotP.gnu'

#### plot 5 ####
# positioning
set size sx, sy
set origin orix5, oriy1
@pos_top_right
# variables
Rc = word(Rcvec, 5)+0
# labels
set label 3 @Rclabel
# colorbar
set colorbox @colorbar_east
# plotting
load 'plotP.gnu'

#### plot 6 ####
# positioning
set size sx, sy
set origin orix1, oriy2
@pos_bottom_left
# c-axis
set cbrange [-15:10]
set cbtics 5 add ('$0$ dB' 0)
# palette
load 'sequential/Reds.plt'  # see gnuplot-colorbrewer
set palette positive
set palette maxcolors 0
# colorbar
unset colorbox
# variables
Rc = word(Rcvec, 1)+0
# labels
set label 3 ''
# plotting
load 'ploteps.gnu'

#### plot 7 ####
# positioning
set size sx, sy
set origin orix2, oriy2
@pos_bottom
# variables
Rc = word(Rcvec, 2)+0
# plotting
load 'ploteps.gnu'

#### plot 8 ####
# positioning
set size sx, sy
set origin orix3, oriy2
@pos_bottom
# variables
Rc = word(Rcvec, 3)+0
# plotting
load 'ploteps.gnu'

#### plot 9 ####
# positioning
set size sx, sy
set origin orix4, oriy2
@pos_bottom
# variables
Rc = word(Rcvec, 4)+0
# plotting
load 'ploteps.gnu'

#### plot 10 ####
# positioning
set size sx, sy
set origin orix5, oriy2
@pos_bottom_right
# colorbar
set colorbox @colorbar_east
# variables
Rc = word(Rcvec, 5)+0
# plotting
load 'ploteps.gnu'

################################################################################
unset multiplot

# output
call 'plot.plt' 'fig'
