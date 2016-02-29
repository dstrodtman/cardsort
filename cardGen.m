%This program is just to automatically test visual spacing of stimuli on
%screens of different sizes. These numbers will be fixed once final
%hardware is decided so as to prevent potential processing delays. I am
%aware of code redundancies, but wanted to make it easy to change constants
%to determine final layout.

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

% Set cards to draw
Screen('FillRect', window, 1, finalCard);
Screen('FrameRect', window, .5, finalCard, 5);
