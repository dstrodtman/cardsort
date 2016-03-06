%This is the first test for establishing that I can, in fact, move the
%cards that I am drawing. Eventually functionality to include detecting
%whether or not card center is inside a target rectangle. If so, rect will
%be highlighted (maybe?) and card will snap to rect center.

% Set initial mouse position to center of screen (where no stimuli are)
SetMouse(xCenter, yCenter, window);

% Offset toggle, to prevent square center snapping to mouse.
offsetSet = 0;

% Draw stimuli to screen
Screen('FillRect', window, 1, stringId{this,5});
Screen('FrameRect', window, .5, stringId{this,5}, 5);
Screen('FillRect', window, 1, cell2mat(stringId{this,7}')');
Screen('FrameRect', window, .5, cell2mat(stringId{this,7}')', 5);

% Set initial active target to the left
activeTar = 1;

% Highlight active target
Screen('FrameRect', window, [0 1 0], stringId{this,6}{activeTar}, 5);

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Loop the animation until a key is pressed
while ~complete || ~proceed

    % Get the current position of the mouse
    [mx, my, buttons] = GetMouse(window);

    % See if the mouse cursor is inside a card
    for ii = 1:12
        while IsInRect(mx, my, stringId{this,7}{ii})
            cardnum = ii;
            selected = stringId{this,7}{ii};
            activeCard;
        end
    end
    
    % Proceed to next
    if complete && IsInRect(mx, my, [0. 0, 100, 100]) && sum(buttons) > 0
        proceed = 1;
    end
end
