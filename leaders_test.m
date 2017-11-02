% IMPORTANT NOTE - prior to running code, turn on sticky keys and lock
% shift key on so that multiple leaders can be clicked at a time. To do
% this, hit shift key 5 times, say "yes" then hit shift twice to lock on.
% Once done running the code, click any two keys at the same time to turn
% sticky keys off.

%%
clear all
close all
clc
itnum = [5:5:60];
%itnum = [20];

load('vel-EGF(E6)w54.mat');
pointsize=50;
% filter out positions if no associated velocity
for ii = 1:size(storeXh,1)
    for jj = 1:size(storeXh,2)
        if isnan(velR(ii,jj))==1 && isnan(storeXh(ii,jj))==0
            storeXh(ii,jj) = NaN;
            storeYh(ii,jj) = NaN;
        end
    end
end
datastoreL = cell(2,numel(itnum));
counter = 1;
counterx = 1;
%for i = [1:19:40]
for i= itnum
figure;
% B= scatter(storeXh(:,i),storeYh(:,i),pointsize,velR(:,i),'filled');
% colorbar

fast= find(velR(:,i)>=quantiles(1,i));
fastest= find(velR(:,i)>=quantiles(4,i));

for ii = fast(:,1);
storeXhfast=storeXh(ii,i);
storeYhfast=storeYh(ii,i);
end

for iii = fastest(:,1);
storeXhfastest=storeXh(iii,i);
storeYhfastest=storeYh(iii,i);
end
cmap=[77 175 74; 228 26 28; 55 126 184; 255 127 0; 50 50 50; 0 0 0]./256;

%orange for middle speed
pointsize= 200;
scatter(storeXh(fast,i),storeYh(fast,i),pointsize,cmap(4,:),'filled');
hold on
%red for high speed
pointsize= 200;
scatter(storeXh(fastest,i),storeYh(fastest,i),pointsize,cmap(2,:),'filled');
hold on
% black for low speed
pointsize= 70;
L=scatter(storeXh(:,i),storeYh(:,i),pointsize,cmap(5,:),'filled');


brush on 
brush green

hold off

pause

brushedDataL = find(get(L,'BrushData'));


if isempty(brushedDataL)
countern=1;
brushedDataL = NaN;
leaderXpos= NaN;
leaderYpos= NaN;
macrodataL = [brushedDataL' leaderXpos leaderYpos];
datastoreL{1,counter} = macrodataL;
followerXpos= NaN;
followerYpos= NaN;
brushedDataF= NaN;
countert = countert + 1;
macrodataF = [brushedDataF' followerXpos followerYpos];
datastoreF{1,counterx} = macrodataF;
datastoreZ{countern,1}=macrodataF;
    % if isempty(brushedDataL);
% %% ???
% else    
elseif ~isempty(brushedDataL)
leaderXpos=storeXh(brushedDataL,i);
leaderYpos=storeYh(brushedDataL,i);
macrodataL = [brushedDataL' leaderXpos leaderYpos];
datastoreL{1,counter} = macrodataL;
brush off
close all

NumLeadersTemp=size(brushedDataL(1,:));
NumLeaders=NumLeadersTemp(:,2);
%save a figure with leader locations
h = figure;
set(h, 'visible', 'off')
pointsize = 200;
scatter(leaderXpos(:,1),leaderYpos(:,1),pointsize,cmap(1,:),'filled','magenta');
hold on
pointsize= 70;
scatter(storeXh(:,i),storeYh(:,i),pointsize,cmap(5,:),'filled');
saveas(h,sprintf('Leaders%d.png',i));

datastoreZ = cell(numel(NumLeaders),1);
countert = 1;

%identify followers    
for ii = 1:NumLeaders
figure;    
pointsize = 200;
scatter(leaderXpos(:,1),leaderYpos(:,1),pointsize,cmap(1,:),'filled','magenta');
hold on
pointsize= 70;
F=scatter(storeXh(:,i),storeYh(:,i),pointsize,cmap(5,:),'filled');

% replot the cells you have already selected!
pointsize = 70;

for uu = 1:ii-1
    clustermat = datastoreZ{uu,1};
    scatter(clustermat(:,2),clustermat(:,3),pointsize,[0 1 0],'filled'); 
    
end

brush on 
brush green

hold off

pause

brushedDataF = find(get(F,'BrushData'));

followerXpos=storeXh(brushedDataF,i);
followerYpos=storeYh(brushedDataF,i);
macrodataF = [brushedDataF' followerXpos followerYpos];
datastoreF{ii,counterx} = macrodataF;
datastoreZ{countert,1}=macrodataF;
countert = countert + 1;

brush off
end
end
datastoreL{2,counter} = datastoreZ;
counterx = counterx + 1;
counter = counter + 1; 
end   
%end
%%
% extract cells
% for k = 1:size(positionFt,1)
%     x=positionFt{k};
% end
% %%
% test3=extractmycells(positionFt(:,1));
% 
% function test2=extractmycells(test2)
% if iscell(test2)
%     test2=cellfun(@extractmycells,test2,'UniformOutput',0);
%     test2=cat(1,test2{:});
% else
%     test2={test2};
% end
% end


% columns = size(datastoreL,2);
% for kk = 1:columns
%      positionLt = datastoreL{1,kk};
%positionFt = datastoreL{2,1};
%      positionLx = positionLt(:,2);
%      positionLy = positionLt(:,3);
%      followers=size(positionFt,1);
%      for jj = 1:followers
%          
%      positionFx = positionFt(jj(:,2),kk);
%      positionFy = positionFt(jj(:,3),kk);
%      end 
% end  

    
%%
%set up movie
% writerObj=VideoWriter('w67_fast.avi');
% writerObj.FrameRate = 2;
% open (writerObj);
%fid= figure;
% itnum=[1:20:60];
% for i= itnum
% %figure(fid);
% figure;
% 
% % B= scatter(storeXh(:,i),storeYh(:,i),pointsize,velR(:,i),'filled');
% % colorbar
% 
% fast= find(velR(:,i)>=quantiles(1,i));
% fastest= find(velR(:,i)>=quantiles(4,i));
% 
% for ii = fast(:,1);
% storeXhfast=storeXh(ii,i);
% storeYhfast=storeYh(ii,i);
% end
% for iii = fastest(:,1);
% storeXhfastest=storeXh(iii,i);
% storeYhfastest=storeYh(iii,i);
% end
% cmap=[77 175 74; 228 26 28; 55 126 184; 255 127 0; 50 50 50; 0 0 0]./256;
% % black for low speed
% pointsize= 70;
% scatter(storeXh(:,i),storeYh(:,i),pointsize,cmap(5,:));
% hold on
% %orange for middle speed
% scatter(storeXh(fast,i),storeYh(fast,i),pointsize,cmap(4,:),'filled');
% hold on
% %red for high speed
% pointsize = 70;
% 
% L= scatter(storeXh(fastest,i),storeYh(fastest,i),pointsize,cmap(2,:),'filled');
% 
% 
% 
% pause
% 
% brushedData = find(get(L,'BrushData'));
% leaderXpos=storeXh(brushedData,i);
% leaderYpos=storeYh(brushedData,i);
% macrodata = [brushedData' leaderXpos leaderYpos];
% datastore{1,counter} = macrodata;
% counter = counter + 1;
% brush off
% close all
% 
% scatter(leaderXpos(:,i),leaderYpos(:,i),pointsize,cmap(1,:),'filled');
% % frame=getframe(gcf);
% % writeVideo(writerObj, frame);
% end

% hold off
% close(writrObj);


