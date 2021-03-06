% comparison of spat. aliasing and SBL freq. with localisation bias

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

SFS_start;  % start Sound Field Synthesis Toolbox
addpath('../../matlab');

%% Parameters
conf = SFS_config;  % default configuration SFS Toolbox

% === SFS compatible parameters ===
% config for loudspeaker array
conf.secondary_sources.size = 3;
conf.secondary_sources.geometry = 'circular';
conf.secondary_sources.number = 56;
conf.secondary_sources.logspread = 1.0;

conf.c = 343;
conf.xref = [0, -1, 0];

% === custom parameters
conf.xs = [0, 2.5, 0];
conf.src = 'ps';
conf.Rc = NaN;
conf.xc = NaN;
conf.Rl = 0.085;
conf.xl = NaN;
conf.M = NaN;
conf.falfile = 'fal.txt';
conf.fcsfile = 'fcs.txt';

%% Parameters which should be iterated

param_names = {
  'secondary_sources.number', ...
  'M', ...
  'Rc', ...
  'xc', ...
  'xl', ...
};

% listening positions
x = [0.00; 0.50; 1.00; 0.00; 0.50; 1.00; 1.25;  0.00;  0.50;  1.00]*(-1);
y = [0.75; 0.75; 0.75; 0.00; 0.00; 0.00; 0.00; -0.75; -0.75; -0.75];
z = [0.00; 0.00; 0.00; 0.00; 0.00; 0.00; 0.00;  0.00;  0.00;  0.00];

xl = num2cell([x,y,z], 2);

%% Compute Spatial Aliasing Frequency

param_values = {};

% Experiment 1: 
% 7 x NFCHOA 
param_values = [param_values; allcombs( ...
  { 56 }, ...
  { 6, 13, 27, 300, 6, 13, 27 }, ...
  { NaN }, ...
  { [0,0,0] }, ...
  xl ...
)];

% Experiment 2: 
% WFS
param_values = [param_values; allcombs( ...
  { 56 }, ...
  { NaN }, ...
  { inf }, ...
  { [0,0,0] }, ...
  xl ...
)];
% NFCHOA
param_values = [param_values; allcombs( ...
  { 56 }, ...
  { 27 }, ...
  { NaN }, ...
  { [0,0,0] }, ...
  xl ...
)];
% 4 x LWFS-SBL
param_values = [param_values; allcombs( ...
  { 56 }, ...
  { 27, 27, 3, 3 }, ...
  { NaN }, ...
  xl, ...
  xl, ...
  [1, 2, 3, 4, 4] ...
)];
% 3 x LWFS-VSS
param_values = [param_values; allcombs( ...
  { 56 }, ...
  { NaN }, ...
  { 0.15, 0.30, 0.45 }, ...
  xl, ...
  xl, ...
  [1, 2, 3, 4, 4] ...
)];

% Experiment 3: 
param_values = [param_values; allcombs( ...
  { 56, 28, 14 }, ...
  { NaN }, ...
  { inf }, ...
  { [0,0,0] }, ...
  xl ...
)];

param_values = [param_values; allcombs( ...
  { 56, 28, 14, 14 }, ...
  { 28, 14,  7, 28 }, ...
  { NaN }, ...
  { [0,0,0] }, ...
  xl, ...
  [1, 1, 3, 4, 5] ...
)];

param_values
%%

delete(conf.falfile)
delete(conf.fcsfile)
exhaustive_evaluation(@spatial_aliasing_frequency, param_names, param_values, conf, false);
exhaustive_evaluation(@correct_synthesis_frequency, param_names, param_values, conf, false);

%%

fal = dlmread('fal.txt', ',', 2, 0);
fcs = dlmread('fcs.txt', ',', 2, 0);
fcs = min(fcs, 60000);

filenames = {
    'exp1_NFCHOA_L56_R006'
    'exp1_NFCHOA_L56_R013'
    'exp1_NFCHOA_L56_R027'
    'exp1_NFCHOA_L56_R300'
    'exp1_NFCHOA_L56_M006'
    'exp1_NFCHOA_L56_M013'
    'exp1_NFCHOA_L56_M027'
    'exp2_WFS_L56'
    'exp2_NFCHOA_L56_R027'
    'exp2_LWFS-SBL_L56_R027'
    'exp2_LWFS-SBL_L56_M027'
    'exp2_LWFS-SBL_L56_R003'
    'exp2_LWFS-SBL_L56_M003'
    'exp2_LWFS-VSS_L56_r15'
    'exp2_LWFS-VSS_L56_r30'
    'exp2_LWFS-VSS_L56_r45'
    'wierstorf_WFS_L56'
    'wierstorf_WFS_L28'
    'wierstorf_WFS_L14'
    'wierstorf_NFCHOA_L56_R028'
    'wierstorf_NFCHOA_L28_R014'
    'wierstorf_NFCHOA_L14_R007'
    'wierstorf_NFCHOA_L14_R028'
};

types = [
    1
    1
    1
    1
    1
    1
    1
    3
    1
    4
    4
    4
    4
    5
    5
    5
    3
    3
    3
    1
    1
    1
    1
    ];

markers = {
    'r'
    'm'
    'b'
    'k'
    'g'
};

idx = 0;
fdx = 1;
err_whole = [];
fal_whole = [];
fcs_whole = [];
type_whole = [];
for file = filenames.'
    
    [~, data] = gp_load(['../fig09/', file{1}, '_loc.txt']);
    
    err_mean = abs(data(:,3));
    
    faltmp = fal(idx+1:idx+length(err_mean));
    fcstmp = fcs(idx+1:idx+length(err_mean));
        
    % faltmp = 180 - 180./(1+exp(-faltmp./180));
    % fcstmp = 180 - 180./(1+exp(-fcstmp./180));
    
    figure(1);
    scatter(faltmp, fcstmp, err_mean.*10, ['o' markers{types(fdx)}] );
    hold on;
    
    [datx, daty] = gp_load(['../fig09/', file{1}, '_corrected.txt']);
    err = [abs(datx), abs(daty)];
    
%     err_whole = [err_whole; err(:)];
%     fal_whole = [fal_whole; repmat(faltmp(:), size(err,2), 1)];
%     fcs_whole = [fcs_whole; repmat(fcstmp(:), size(err,2), 1)];


    err_whole  = [ err_whole; err_mean(:)];
    fal_whole  = [ fal_whole; faltmp];
    fcs_whole  = [ fcs_whole; fcstmp];
    type_whole = [type_whole; types(fdx.*ones(length(err_mean),1))];
    
    figure(2);
    subplot(1,2,1);
    plot(faltmp, err, ['o' markers{types(fdx)}] );
    hold on;
    subplot(1,2,2);
    plot(fcstmp, err, ['o' markers{types(fdx)}] );
    hold on;
    
    perr = sum(err <= 5, 2)./size(err,2);
    
    figure(3);
    subplot(1,2,1);
    plot(faltmp, perr, ['o' markers{types(fdx)}] );
    hold on;
    subplot(1,2,2);
    plot(fcstmp, perr, ['o' markers{types(fdx)}] );
    hold on;
    
    idx = idx+length(err_mean);
    fdx = fdx+1;
end
hold off;

figure(1);
set(gca, 'YScale', 'log');
set(gca, 'XScale', 'log');
xlabel('fal');
ylabel('fcs');
zlabel('localisation error');
legend(filenames, 'Interpreter', 'None');

figure(2);
subplot(1,2,1);
% set(gca, 'YScale', 'log');
set(gca, 'XScale', 'log');
xlabel('fal');
ylabel('localisation error');
subplot(1,2,2);
% set(gca, 'YScale', 'log');
set(gca, 'XScale', 'log');
xlabel('fcs');
ylabel('localisation error');

gp_save('data.txt', [fal_whole, fcs_whole, err_whole, type_whole]);
