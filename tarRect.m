
%This program is just to automatically test visual spacing of stimuli on
%screens of different sizes. These numbers will be fixed once final
%hardware is decided so as to prevent potential processing delays. I am
%aware of code redundancies, but wanted to make it easy to change constants
%to determine final layout.

% Creates random number of target rects, testing functionality
tarNum = randi([3,7]);

% Set rectangle dimensions
rectX = 150;
rectY = 200;

% Set rectangle spacing
rectSpace = 25;

% Build target rectangle matrix and set height
rectMat = repmat([0; 0; 0; rectY], 1, tarNum);

% Set X
for ii = (1:tarNum)
    rectMat([1, 3],ii) = [0, rectX] + (rectX + rectSpace) * (ii-1);
end

% Build matrix to center rects in top half of screen.
xshift = (screenXpixels - rectMat(1,tarNum)) / 2 - rectX / 2;
yshift = yCenter - .5*yCenter - .5*rectY;
matShift = repmat([xshift; yshift], [2, tarNum]);

% Adjust rect coordinates to top half of screen.
finalTarRect = rectMat + matShift;

% Set targets to draw
Screen('FillRect', window, 1, finalTarRect);
Screen('FrameRect', window, .5, finalTarRect, 5);

%Assign each target an identity
idTargets;