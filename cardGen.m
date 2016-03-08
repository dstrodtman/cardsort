function [card, card2, cardData] = cardGen(screenXpixels,yCenter)

%Presently creates 12 unique cards to be sorted and assigns original card
%coordinates.

% Set card dimensions
cardX = 140;
cardY = 100;

% Set horizontal spacing
cardHspace = 30;

% Set vertical spacing
cardVspace = 50;

% Build 6 card matrix and set height (1st row)
cardMat = repmat([0; 0; 0; cardY], 1, 6);

% Set X for 1st row
for ii = (1:6)
    cardMat([1, 3],ii) = [0, cardX] + (cardX + cardHspace) * (ii-1);
end

% Add 6 cards for 2nd row
cardMat = repmat(cardMat, 1, 2);

% Shift 2nd row
cardMat([1, 3], 7:12) = cardMat([1, 3], 7:12) + .5 * cardX;
cardMat([2, 4], 7:12) = cardMat([2, 4], 7:12) + cardY + cardVspace;

% Build matrix to center rects in top half of screen.
cardXshift = (screenXpixels - cardMat(3,12)) / 2;
cardYshift = yCenter + .5*yCenter - .5*cardMat(4,12);
cardShift = repmat([cardXshift; cardYshift], [2, 12]);

% Adjust card coordinates to bottom half of screen.
finalCard = cardMat + cardShift;

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

card2 = card;
