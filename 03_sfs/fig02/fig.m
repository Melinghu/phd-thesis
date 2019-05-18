% reproduced sound field for 2.5D NFCHOA of monochromatic plane wave

%*****************************************************************************
% Copyright (c) 2019      Fiete Winter                                       *
%                         Institut fuer Nachrichtentechnik                   *
%                         Universitaet Rostock                               *
%                         Richard-Wagner-Strasse 31, 18119 Rostock, Germany  *
%                                                                            *
% This file is part of the supplementary material for Fiete Winter's         *
% PhD thesis                                                                 *
%                                                                            *
% You can redistribute the material and/or modify it  under the terms of the *
% GNU  General  Public  License as published by the Free Software Foundation *
% , either version 3 of the License,  or (at your option) any later version. *
%                                                                            *
% This Material is distributed in the hope that it will be useful, but       *
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY *
% or FITNESS FOR A PARTICULAR PURPOSE.                                       *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy of the GNU General Public License along   *
% with this program. If not, see <http://www.gnu.org/licenses/>.             *
%                                                                            *
% http://github.com/fietew/phd-thesis                 fiete.winter@gmail.com *
%*****************************************************************************

SFS_start;
%% Parameters
conf = SFS_config;

conf.secondary_sources.geometry = 'sphere';
conf.secondary_sources.grid = 'gauss';
conf.secondary_sources.size = 3;
conf.secondary_sources.center = [0 0 0];
conf.secondary_sources.number = 2*35^2;

conf.dimension = '3D';

%% Variables
src = 'pw';
xs = [0,  -1, 0];
xref = conf.xref;

X = [-1.5, 1.5];
Y = [-1.5, 1.5];
Z = 0;

%% Computation
for f=[200, 500, 1000]
  for tap = [0 1]
    % ground truth
    Ppw_gt = sound_field_mono_plane_wave(X,Y,Z,xs,f,conf);
    % secondary source
    x0 = secondary_source_positions(conf);
    x0 = secondary_source_selection(x0,xs,src);    
    % custom tapering
    if tap
      x0(:,7) = x0(:,7).*sum(bsxfun(@times, x0(:,4:6), xs),2);
    end
    % driving function
    D = driving_function_mono_wfs(x0,xs,src,f,conf);
    % reproduced sound field
    [Ppw,x,y] = sound_field_mono(X,Y,Z,x0,'ps',D,f,conf);
    % normalised absolute error
    Ppw_error = abs(1 - Ppw./Ppw_gt);
    % normalisation factor for gnuplot
    gpw = sound_field_mono_plane_wave(xref(1),xref(2),xref(3),xs,f,conf);
    % gnuplot
    gp_save_matrix(sprintf('Ppw_error_f%d_tap%d.dat',f,tap),x,y,db(Ppw_error));
  end
end

% gnuplot
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.number = 1024;
x0 = secondary_source_positions(conf);
[~, xdx] = secondary_source_selection(x0,xs,src);

x0_inactive = x0(~xdx,:);
phi0_inactive = cart2pol(x0_inactive(:,1), x0_inactive(:,2));
phis = cart2pol(xs(1), xs(2));
delta = wrapToPi(phi0_inactive-phis);
[~,idx] = sort(delta);   

gp_save_loudspeakers('array_active.txt', x0(xdx,:));
gp_save_loudspeakers('array_inactive.txt', x0_inactive(idx,:));