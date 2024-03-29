% main_code.m

% Copyright (c) Prasanth "Prash" Ganesan
% Author email: <prasganesan.pg@gmail.com>

% Technique of Bayesian search reproduced from paper mentioned in the readme document of this repository

N = 100;

for n = 1 : N
    clearvars -except C B0 Initial_Areaa N m n Areaah Bhist Sk Time Obj Decision; 

    Areaa = Initial_Areaa;
    visual = 0;
    X = 100;  % Location of the object
    alf = 0.2; bet = 0.3;
    % alf =0; bet = 0; % No FP/FN
    B_upper = 0.9;
    B_lower = 0.05;
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
        if sk ~= X 
            count1 = count1 + 1;
            if count1 == 11
                count1 = 1;
                Y_t = zeros(1,10);
                Y_t(randi(10,1,2)) = 1;
            end
            Y_sk = Y_t(count1);              
        else
            count2 = count2 + 1;
            if count2 == 11
                count2 = 1;
                Y_t = zeros(1,10);
                Y_t(randi(10,1,7)) = 1;
            end      
            Y_sk = Y_t(count2);
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

        Areaa = pct;
        if visual==1
            bfig=bar3(Areaa);
            drawnow;
            hold on;
            [row,col] = ind2sub(size(Areaa),sk);
            plot3(row, col, Areaa(sk), 'ro', 'MarkerSize', 25);
            [row,col] = ind2sub(size(Areaa),X);
            plot3(row, col, Areaa(X), 'k.', 'MarkerSize', 20);
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
            decision_flag = 1;
            check = find(pct>=B_upper);
            if ~isempty(check)
                obj_Loc = check;
                break;
            else
                continue;
            end 
        elseif B <= B_lower
            decision_flag = 0;
            obj_Loc = nan;
        end
    end

    eval(['Areaah.Areaa_hist' num2str(n) '= Areaa_hist;'])
    eval(['Bhist.B_hist' num2str(n) '= B_hist;'])
    eval(['Sk.sk_hist' num2str(n) '= sk_hist;'])
    eval(['Time.tot_time' num2str(n) '= time;'])
    eval(['Obj.obj_Loc' num2str(n) '= obj_Loc;'])
    eval(['Decision.decision_flag' num2str(n) '= decision_flag;'])
    disp(n)
end


