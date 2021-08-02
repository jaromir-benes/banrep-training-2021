%% ------------------------------------------------------------
%% DRIVER_IRF_PPD
%% ------------------------------------------------------------
%  Michal Andrle, MANDRLE@IMF.ORG, IMF RES
%
% August, 2021
%
%

% housekeeping
clear; close all; clc;

% load the model [model, params, sstate]
[m P ss] = readmodel(false);

% call the marginal priors (mpriors)
E = set_mpriors(P);

% -------------------------------
% Resample from the prior IRFs
% -------------------------------
N = 500; % number of samples
shoxlist = {'SHK_L_GDP_GAP',...
	        'SHK_DLA_CPIXFE',...
	        'SHK_L_S',...
	        'SHK_RS_UNC',...
	        'SHK_L_GDP_RW_GAP',...
	        };

	[X Z] = sample_mpriors(E, N);
	[SM IRFcal nFails] = sample_irfs(m, shoxlist, Z, 1:30);
fprintf('Done. \n');





% ------------------------------------------
% Process the IRFs -- plot PRCTILES
% ------------------------------------------
list = {'L_GDP_GAP','RS_UNC','DLA_CPIXFE'};

for sh = 1 : numel(shoxlist)
	x_ygap = extract_irf(SM, list, sh);

	f = figure();
	for i = 1 : numel(list);
		pct = prctile(squeeze(x_ygap(:,:,i))',[5:5:100]);
		cal = IRFcal.(list{i}){0:end,sh}(:);
	
		subplot(2,2,i);
			plot(pct','color',[0.5 0.5 0.5]);
			hold on;
			plot(cal,'color','b','linewidth',2);

		v_str = strrep(list{i},'_','\_');
		s_str = strrep(shoxlist{sh},'_','\_');
		title(sprintf('%s <- %s',v_str, s_str));

	end % i
end % sh



% ------------------------------------------
% Process the IRFs -- plot random profiles
% ------------------------------------------
K = 90; % number of randomly chosen profiles

for sh = 1 : numel(shoxlist)
	x_ygap = extract_irf(SM, list, sh);

	f = figure();
	for i = 1 : numel(list);

		wat = datasample(1:N,K,'Replace',false);
		sel = squeeze(x_ygap(:,wat,i))';

		cal = IRFcal.(list{i}){0:end,sh}(:);
	
		subplot(2,2,i);
			plot(sel','color',[0.5 0.5 0.5]);
			hold on;
			plot(cal,'color','b','linewidth',2);

		v_str = strrep(list{i},'_','\_');
		s_str = strrep(shoxlist{sh},'_','\_');
		title(sprintf('%s <- %s',v_str, s_str));

	end % i
end % sh


% -------------------------------
% Resample spriors/posterior IRFs
% -------------------------------

% load |dat| and other posterior stuff
POST = load('rwm_1.mat');
m_pos = m; m_pos = assign(m_pos,POST.est_out.P); m_pos = solve(m_pos);
wat = datasample(1:numel(POST.ZPOS),min(500,numel(POST.ZPOS)),'Replace',false);
[SM_post IRF_post nFails_post] = sample_irfs(m_pos, shoxlist, POST.ZPOS(wat), 1:30);



% ------------------------------------------
% Process the IRFs -- compare two variants
% ------------------------------------------
list = {'L_GDP_GAP','RS_UNC','DLA_CPIXFE'};

for sh = 1 : numel(shoxlist)
	x_ygap = extract_irf(SM, list, sh);

	f = figure();
	for i = 1 : numel(list);
		pct = prctile(squeeze(x_ygap(:,:,i))',[10:10:100]);
		cal = IRFcal.(list{i}){0:end,sh}(:);
		pos = IRF_post.(list{i}){0:end,sh}(:);
	
		subplot(2,2,i);
			plot(pct','color',[0.9 0.9 0.9]);
			hold on;
			p1_ = plot(cal,'color','b','linewidth',2);
			hold on;
			p2_ = plot(pos,'color','r','linewidth',2);

		v_str = strrep(list{i},'_','\_');
		s_str = strrep(shoxlist{sh},'_','\_');
		title(sprintf('%s <- %s',v_str, s_str));

	end % i
end % sh






