%% Simulation reproduced

N = 100;
% m = matfile('C:\Users\pg8709\Documents\MATLAB\Courses\Fall 2015\MQE\data.mat','Writable',true);


for n = 1 : N

clearvars -except C B0 Initial_Areaa N m n Areaah Bhist Sk Time Obj Decision; 

% str=['Hist.mat'];

Areaa = Initial_Areaa;

visual = 0;

X = 100;  % Location of the object
alf = 0.2; bet = 0.3;
% alf =0; bet = 0; % No FP/FN
B_upper = 0.9;
B_lower = 0.05;

% Random vector for FP/FN
% Y_sk=rand(sqrt(C))<=alf;
% Y_sk=zeros(sqrt(C)); % No FP/FN
% Y_sk = ones(sqrt(C));
% temp=rand(1,10)>beta;
% Y_sk(X) = 1;


pct = Areaa;
B=B0;
time=0;
start = 1;
sk = start; % Initial location of searcher

count1 = 10; count2 = 10; 

while (B > B_lower)
    time=time+1;
    
    Areaa_before = Areaa;
    
    if time == 1
        pst_before = pct(start);
        pct_before = Areaa;
    else
        pst_before = Areaa_before(sk);
        pct_before = pct;
    end
    
%     phi = ((1-alf) .* (1-Y_sk(sk))) + (alf .* Y_sk(sk));
%     psi =  (bet .* (1-Y_sk(sk))) + ((1-bet) .* Y_sk(sk));
    
    if sk ~= X 
        count1 = count1 + 1;
        if count1 == 11
            count1 = 1;
            Y_t = zeros(1,10);
            Y_t(randi(10,1,2)) = 1;
%             eval(['m.' str '.Y_t=Y_t;']);
        end
            Y_sk = Y_t(count1);
%         end       
%         if count1 > 8
%             Y_sk = 1;            
%         else
%             Y_sk = 0;
%         end
        
        
    else
        count2 = count2 + 1;
        if count2 == 11
            count2 = 1;
            Y_t = zeros(1,10);
            Y_t(randi(10,1,7)) = 1;
        end      
        Y_sk = Y_t(count2);
%         if count2 > 7
%             Y_sk = 1;
%         else
%             Y_sk = 0;
%         end
    end
            
    phi = ((1-alf) .* (1-Y_sk)) + (alf .* Y_sk);
    psi =  (bet .* (1-Y_sk)) + ((1-bet) .* Y_sk);
    omeg = psi - phi;
        
    for Loc = 1:C
        if Loc == sk
            theta_c = psi;
        else
            theta_c = phi;
        end

        pct(Loc) = (theta_c .* pct_before(Loc)) / (phi + (omeg.* pst_before)); 
         Y = sprintf('%.6f',pct(Loc));
         pct(Loc)=str2double(Y);
    end

%   pct_before = pct(Loc);
    
    Areaa = pct;
    
    if visual==1
        bfig=bar3(Areaa);
        drawnow;
        hold on;
        [row,col] = ind2sub(size(Areaa),sk);
        plot3(row, col, Areaa(sk), 'ro', 'MarkerSize', 25);
        [row,col] = ind2sub(size(Areaa),X);
        plot3(row, col, Areaa(X), 'k.', 'MarkerSize', 20);
    %     pause(0.01)
        xlabel x
        ylabel y
        zlabel z

        % Make the colorbar according to height of the bar rather than acoording to
        % x and y values
        for k = 1:length(bfig)
            zdata = bfig(k).ZData;
            bfig(k).CData = zdata;
            bfig(k).FaceColor = 'interp';
        %     bfig(k).LineWidth = 2; % to change the linewidth of the edge of the
        %     bar plot
        end
        drawnow;
        hold off;
        pause (1.5)
    end
    

 B = sum(sum(pct));
 %time
 B_hist(time) = B; 
 Areaa_hist{time} = Areaa;
 
 % Myopic search - 8 point connectivity - determine searchers next location
 [row,col] = ind2sub(size(Areaa),sk);
 [neighbors, inds] = neighs(row, col, Areaa);
 
 [val,indx] = max(neighbors);
 if length(find([pct(sk), neighbors] == 0)) == length([pct(sk), neighbors])
     nz = find(pct(:) ~= 0);
     sk_hist(time) = sk;
     mz = min(abs(nz - sk));
     sk = mz(1);    
 elseif isequal([repmat(pct(sk),1,length(neighbors))], neighbors)
     skr = inds{1}(1);
     skc = inds{1}(2);
     sk_hist(time) = sk;
     sk = sub2ind(size(Areaa), skr, skc);
 elseif val > pct(sk)
     indx = indx(1);
     skr = inds{indx}(1);
     skc = inds{indx}(2);
     sk_hist(time) = sk;
     sk = sub2ind(size(Areaa), skr, skc); % searchers new location
 else
     sk_hist(time) = sk;
 end
 
 
%  % Saccadic search
%  val = find(pct == max(max(pct)));
%  sk_hist(time) = sk;
%  sk = val(1); % searchers new location
 

if B >= B_upper
%     disp('Object Present');
    decision_flag = 1;
    check = find(pct>=B_upper);
    if ~isempty(check)
%         obj_Loc = find(pct==max(max(pct)));
        obj_Loc = check;
        break;
    else
        continue;
    end
%     pct(obj_Loc)
    
elseif B <= B_lower
    decision_flag = 0;
    obj_Loc = nan;
%     disp('Object absent');
end

end

eval(['Areaah.Areaa_hist' num2str(n) '= Areaa_hist;'])
% eval(['m.Areaa=Areaah;'])

eval(['Bhist.B_hist' num2str(n) '= B_hist;'])
% eval(['m.B=Bhist;'])

eval(['Sk.sk_hist' num2str(n) '= sk_hist;'])
% eval(['m.Sk=Sk;'])

eval(['Time.tot_time' num2str(n) '= time;'])
% eval(['m.Time=Time;'])

eval(['Obj.obj_Loc' num2str(n) '= obj_Loc;'])
% eval(['m.Obj=Obj;'])

eval(['Decision.decision_flag' num2str(n) '= decision_flag;'])

disp(n)

end
 


% pct= (prod_theta_c .* pc0)/(prod_phi + f_kty);
% f_kty=prod_theta_s



