% neighs.m

% Copyright (c) Prasanth "Prash" Ganesan
% Author email: <prasganesan.pg@gmail.com>

% This code is a naive way to find the neighbor elements of a given location of a matrix

function [neighbors, inds] = neighs(row, col, Areaa)
    if nargout == 1 && nargin <= 3
        error('Error in funtion neighs : Not enough inputs');
    end

    if nargin < 2
        error('Error in funtion neighs : Not enough inputs');
    elseif nargin == 3    
        neighbors = [];
        inds = {};

        if row ~= 1 && row ~= size(Areaa,1) && col ~= 1 && col ~= size(Areaa,2) 
            neighbors(1) = Areaa(row-1,col-1); % Upper left.  
            neighbors(2) = Areaa(row-1,col); % Upper middle. 
            neighbors(3) = Areaa(row-1,col+1); % Upper right.  
            neighbors(4) = Areaa(row,col-1); % left.  
            neighbors(5) = Areaa(row,col+1); % right. 
            neighbors(6) = Areaa(row+1,col+1); % Lower right. 
            neighbors(7) = Areaa(row+1,col); % lower middle.  
            neighbors(8) = Areaa(row+1,col-1); % Lower left.  
        end

        if row == 1 && col == 1
            neighbors(1) = Areaa(row,col+1); % right.
            neighbors(2) = Areaa(row+1,col); % lower middle.
            neighbors(3) = Areaa(row+1,col+1); % Lower right.
        elseif row == size(Areaa,1) && col == 1
            neighbors(1) = Areaa(row-1,col); % Upper middle.
            neighbors(2) = Areaa(row,col+1); % right.
            neighbors(3) = Areaa(row-1,col+1); % Upper right.
        elseif row == 1 && col == size(Areaa,2)
            neighbors(1) = Areaa(row,col-1); % left.
            neighbors(2) = Areaa(row+1,col); % lower middle.
            neighbors(3) = Areaa(row+1,col-1); % Lower left.
        elseif row == size(Areaa,1) && col == size(Areaa,2)
            neighbors(1) = Areaa(row,col-1); % left.
            neighbors(2) = Areaa(row-1,col); % Upper middle.
            neighbors(3) = Areaa(row-1,col-1); % Upper left.
        end

        if row ~= 1 && row ~= size(Areaa,1) && col == 1
            neighbors(1) = Areaa(row-1,col); % Upper middle. 
            neighbors(2) = Areaa(row-1,col+1); % Upper right.
            neighbors(3) = Areaa(row,col+1); % right. 
            neighbors(4) = Areaa(row+1,col+1); % Lower right. 
            neighbors(5) = Areaa(row+1,col); % lower middle.
        elseif row ~= 1 && row ~= size(Areaa,1) && col == size(Areaa,2)
            neighbors(1) = Areaa(row-1,col-1); % Upper left.  
            neighbors(2) = Areaa(row-1,col); % Upper middle. 
            neighbors(3) = Areaa(row+1,col); % lower middle.  
            neighbors(4) = Areaa(row+1,col-1); % Lower left.
            neighbors(5) = Areaa(row,col-1); % left.
        elseif col ~= 1 && col ~= size(Areaa,2) && row == 1
            neighbors(1) = Areaa(row+1,col+1); % Lower right. 
            neighbors(2) = Areaa(row+1,col); % lower middle.  
            neighbors(3) = Areaa(row+1,col-1); % Lower left.
            neighbors(4) = Areaa(row,col-1); % left.  
            neighbors(5) = Areaa(row,col+1); % right.
        elseif col ~= 1 && col ~= size(Areaa,2) && row == size(Areaa,1)
            neighbors(1) = Areaa(row-1,col-1); % Upper left.  
            neighbors(2) = Areaa(row-1,col); % Upper middle. 
            neighbors(3) = Areaa(row-1,col+1); % Upper right.  
            neighbors(4) = Areaa(row,col-1); % left.  
            neighbors(5) = Areaa(row,col+1); % right. 
        end

        % Indices 
        if row ~= 1 && row ~= size(Areaa,1) && col ~= 1 && col ~= size(Areaa,2)
            inds{1} = [row-1,col-1]; % Upper left.  
            inds{2} = [row-1,col]; % Upper middle. 
            inds{3} = [row-1,col+1]; % Upper right.  
            inds{4} = [row,col-1]; % left.  
            inds{5} = [row,col+1]; % right. 
            inds{6} = [row+1,col+1]; % Lower right. 
            inds{7} = [row+1,col]; % lower middle.  
            inds{8} = [row+1,col-1]; % Lower left.          
        end

        if row == 1 && col == 1
            inds{1} = [row,col+1]; % right.
            inds{2} = [row+1,col]; % lower middle.
            inds{3} = [row+1,col+1]; % Lower right.
        elseif row == size(Areaa,1) && col == 1
            inds{1} = [row-1,col]; % Upper middle.
            inds{2} = [row,col+1]; % right.
            inds{3} = [row-1,col+1]; % Upper right.
        elseif row == 1 && col == size(Areaa,2)
            inds{1} = [row,col-1]; % left.
            inds{2} = [row+1,col]; % lower middle.
            inds{3} = [row+1,col-1]; % Lower left.
        elseif row == size(Areaa,1) && col == size(Areaa,2)
            inds{1} = [row,col-1]; % left.
            inds{2} = [row-1,col]; % Upper middle.
            inds{3} = [row-1,col-1]; % Upper left.
        end

        if row ~= 1 && row ~= size(Areaa,1) && col == 1
            inds{1} = [row-1,col]; % Upper middle. 
            inds{2} = [row-1,col+1]; % Upper right.
            inds{3} = [row,col+1]; % right. 
            inds{4} = [row+1,col+1]; % Lower right. 
            inds{5} = [row+1,col]; % lower middle.
        elseif row ~= 1 && row ~= size(Areaa,1) && col == size(Areaa,2)
            inds{1} = [row-1,col-1]; % Upper left.  
            inds{2} = [row-1,col]; % Upper middle. 
            inds{3} = [row+1,col]; % lower middle.  
            inds{4} = [row+1,col-1]; % Lower left.
            inds{5} = [row,col-1]; % left.
        elseif col ~= 1 && col ~= size(Areaa,2) && row == 1
            inds{1} = [row+1,col+1]; % Lower right. 
            inds{2} = [row+1,col]; % lower middle.  
            inds{3} = [row+1,col-1]; % Lower left.
            inds{4} = [row,col-1]; % left.  
            inds{5} = [row,col+1]; % right.
        elseif col ~= 1 && col ~= size(Areaa,2) && row == size(Areaa,1)
            inds{1} = [row-1,col-1]; % Upper left.  
            inds{2} = [row-1,col]; % Upper middle. 
            inds{3} = [row-1,col+1]; % Upper right.  
            inds{4} = [row,col-1]; % left.  
            inds{5} = [row,col+1]; % right. 
        end
    else
        neighbors = [];
        inds = {};

        % Indices 
        if row ~= 1 && row ~= size(Areaa,1) && col ~= 1 && col ~= size(Areaa,2)  
            inds{1} = [row-1,col-1]; % Upper left.  
            inds{2} = [row-1,col]; % Upper middle. 
            inds{3} = [row-1,col+1]; % Upper right.  
            inds{4} = [row,col-1]; % left.  
            inds{5} = [row,col+1]; % right. 
            inds{6} = [row+1,col+1]; % Lower right. 
            inds{7} = [row+1,col]; % lower middle.  
            inds{8} = [row+1,col-1]; % Lower left.  
        end

        if row == 1 && col == 1
            inds{1} = [row,col+1]; % right.
            inds{2} = [row+1,col]; % lower middle.
            inds{3} = [row+1,col+1]; % Lower right.
        elseif row == size(Areaa,1) && col == 1
            inds{1} = [row-1,col]; % Upper middle.
            inds{2} = [row,col+1]; % right.
            inds{3} = [row-1,col+1]; % Upper right.
        elseif row == 1 && col == size(Areaa,2)
            inds{1} = [row,col-1]; % left.
            inds{2} = [row+1,col]; % lower middle.
            inds{3} = [row+1,col-1]; % Lower left.
        elseif row == size(Areaa,1) && col == size(Areaa,2)
            inds{1} = [row,col-1]; % left.
            inds{2} = [row-1,col]; % Upper middle.
            inds{3} = [row-1,col-1]; % Upper left.
        end

        if row ~= 1 && row ~= size(Areaa,1) && col == 1
            inds{1} = [row-1,col]; % Upper middle. 
            inds{2} = [row-1,col+1]; % Upper right.
            inds{3} = [row,col+1]; % right. 
            inds{4} = [row+1,col+1]; % Lower right. 
            inds{5} = [row+1,col]; % lower middle.
        elseif row ~= 1 && row ~= size(Areaa,1) && col == size(Areaa,2)
            inds{1} = [row-1,col-1]; % Upper left.  
            inds{2} = [row-1,col]; % Upper middle. 
            inds{3} = [row+1,col]; % lower middle.  
            inds{4} = [row+1,col-1]; % Lower left.
            inds{5} = [row,col-1]; % left.
        elseif col ~= 1 && col ~= size(Areaa,2) && row == 1
            inds{1} = [row+1,col+1]; % Lower right. 
            inds{2} = [row+1,col]; % lower middle.  
            inds{3} = [row+1,col-1]; % Lower left.
            inds{4} = [row,col-1]; % left.  
            inds{5} = [row,col+1]; % right.
        elseif col ~= 1 && col ~= size(Areaa,2) && row == size(Areaa,1)
            inds{1} = [row-1,col-1]; % Upper left.  
            inds{2} = [row-1,col]; % Upper middle. 
            inds{3} = [row-1,col+1]; % Upper right.  
            inds{4} = [row,col-1]; % left.  
            inds{5} = [row,col+1]; % right. 
        end
    end
end

