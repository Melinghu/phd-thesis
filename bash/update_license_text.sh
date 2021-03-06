#!/bin/bash

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

if [ $# -ne 1 ]
  then
    echo "Incorrect number of arguments ($# provided, 1 expected)"
    exit 1
fi

directory=$1

# update license text in MATLAB files
LIC=$(<copyright-phdthesis-matlab.txt)
export LIC
find $directory -iname "*.m" -type f | while read -r line ; do
    echo "Processing $line"
    perl -i -pe 'BEGIN{undef $/;} s/% Copyright.*uni-rostock.de\*/$ENV{LIC}/smg' "$line"
done

# update license text in gnuplot files
LIC=$(<copyright-phdthesis-gnuplot.txt)
export LIC
find $directory -iname "*.gnu" -type f | while read -r line ; do
    echo "Processing $line"
    perl -i -pe 'BEGIN{undef $/;} s/# Copyright.*uni-rostock.de\*/$ENV{LIC}/smg' "$line"
done
