%Make cards unique entities for movement commands and data tracking. Will
%later communicate with stimuli info.

% Create cell array for cards
card = cell(1, 12);

%Create data repositories for each card
cardData = cell(4, 12);
%Column corresponds to card number
%Row 1: card symbol
%Row 2: click counter 
%Row 3: [start time, stop time] for each click
%Row 4: destination cards, in order placed

%Preallocate for speed
for ii = 1:12
    card{ii} = finalCard(1:4, ii)'; % Define cards 1:12
    cardData{2, ii} = 0; % Set all click counters to 0
    cardData{3, ii} = nan(20,2); % create empty array for 20 clicks times
    cardData{4, ii} = nan(1,10); % create empty array for 10 target places
end