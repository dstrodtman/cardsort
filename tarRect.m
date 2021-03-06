function [tarDims, target, cardOn, centers] = tarRect(strLength,screenXpixels,yCenter)

%This program automatically sets the spacing of targets for each stimuli
%string and adjusts for their length on any size presentation screen.
%Currently set to have card stimuli center on the upper quartile of the
%screen.

% Set target number to string length
tarNum = strLength;

% Set rectangle dimensions
rectX = 150;
rectY = 200;

% Set rectangle spacing
rectSpace = 25;

% Build target rectangle matrix and set height
rectMat = repmat([0; 0; 0; rectY], 1, tarNum);

% Set horizontal location
for ii = (1:tarNum)
    rectMat([1, 3],ii) = [0, rectX] + (rectX + rectSpace) * (ii-1);
end

% Build matrix to center targets in top half of screen.
xshift = (screenXpixels - rectMat(1,tarNum)) / 2 - rectX / 2;
yshift = yCenter - .5*yCenter - .5*rectY;
matShift = repmat([xshift; yshift], [2, tarNum]);

% Adjust target coordinates to top half of screen, output.
tarDims = rectMat + matShift;

%Make targets unique entities for hover highlight, locking, and data
%tracking. Will later communicate with stimuli info.

% Create cell array for targets & centers
target = cell(1, strLength);
centers = cell(1, strLength);

for ii = 1:strLength
    target{ii} = tarDims(1:4, ii)'; % Define targets
    [centers{ii}(1), centers{ii}(2)] = RectCenter(target{ii});
end

% Create cell array for card detection
cardOn = cell(2, strLength);

% Set to false
for ii = 1:(2*strLength)
    cardOn{ii} = 0;
end

