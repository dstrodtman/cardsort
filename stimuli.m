% Prerender all stimuli for the entire presentation (hopefully!)

%Import and define stimuli list
% Cell contents (by column)
% 1: String names
% 2: String lengths
% 3: Symbol cells
% 4: Duplicate symbols
% 5: Target coordinates
% 6: Target number ID
% 7: Original card coordinates
% 8: Array of cells for card data
    %Column corresponds to card number
    %Row 1: card symbol
    %Row 2: click counter 
    %Row 3: [start time, stop time] for each click
    %Row 4: destination cards, in order placed
% 9: Card last on target, moved?
%10: Card centers
%11: Target centers
%12: Order in trial

%Create cell array for string assignments
stringId = cell(90, 12);

%Import string names
stringFeed = textscan(fopen('alphabetic.txt', 'r'), '%s');

%Assign:
for ii = 1:90
    stringId{ii,1} = char(stringFeed{1}(ii)); %String names (column 1)
    stringId{ii,2} = length(stringId{ii,1}); %String lengths (column 2)
    stringId{ii,3} = cellstr(stringId{ii,1}')'; %Create cells for individual symbols
    %Find duplicate symbols
    [~,kk,~] = unique(stringId{ii,3}); 
    for ll = 1:stringId{ii,2}
        if ~any(kk == ll)
            stringId{ii,4}(1, numel(stringId{ii,4}) + 1) = char(stringId{ii,3}(ll));
        end
        
    end
    [stringId{ii,5}, stringId{ii,6}, stringId{ii,9}, stringId{ii,11}] = ...
        tarRect(stringId{ii,2},screenXpixels,yCenter); %Set target coordinates & ID
    [stringId{ii,7}, stringId{ii,8}, stringId{ii,10}] = cardGen(screenXpixels,yCenter); %Set cards
    cardShuffle; % Generate card symbols (fix later for instances of 3 dupes)
    for jj = 1:12
        stringId{ii,8}{1,jj} = bank(jj); % Assign card symbols
    end
end

%Create truly random permutation of presentation order
% rng('shuffle');
presentOrder = randperm(90);
