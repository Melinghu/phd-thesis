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

plot for [idx=1:10] filename.'_ci.txt' u (column(4*idx-3)+r_spread*column(4*idx-1)):(column(4*idx-2)+r_spread*column(4*idx)) with filledcurves lc rgb "grey",\
  filename.'_loc.txt' @localization_grey_line,\
  filename.'_loc.txt' every ::0::5 u 1:2:(print_error(abs($4))) with labels left offset 0.0,-0.35,\
  filename.'_loc.txt' every ::7::9 u 1:2:(print_error(abs($4))) with labels left offset 0.0,-0.35,\
  filename.'_loc.txt' every ::6::6 u 1:2:(print_error(abs($4))) with labels offset 0.0,-0.35,\
  filename.'_RMSE.txt' using (0.5):(0.35):(print_RMSE($1,$3,$4)) with labels left offset 0.0,-0.35,\
  filename.'_RMSE.txt' using (0.5):(-0.15):(print_test($3)) with labels left offset 0.0,-0.35,\
  filename.'_loc.txt' every ::0::1 @localization_arrow,\
  filename.'_loc.txt' every ::2::2 @localization_arrow_artefact lc rgb 'red',\
  filename.'_loc.txt' every ::3::9 @localization_arrow,\
  'array.txt' @array_active,\
  set_point_source(0,2.5) @point_source
  # filename.'_MSE.txt' using (1.0):(0.0):(sprintf('$%1.4f$',$2)) with labels offset 0.0,0.25
