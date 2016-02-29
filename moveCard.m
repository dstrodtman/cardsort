%This is the first test for establishing that I can, in fact, move the
%cards that I am drawing. Eventually functionality to include detecting
%whether or not card center is inside a target rectangle. If so, rect will
%be highlighted (maybe?) and card will snap to rect center.

% Set initial mouse position to center of screen (where no stimuli are)
SetMouse(xCenter, yCenter, window);

% Offset toggle, to prevent square center snapping to mouse.
offsetSet = 0;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Loop the animation until a key is pressed
while ~KbCheck

    % Get the current position of the mouse
    [mx, my, buttons] = GetMouse(window);

    % See if the mouse cursor is inside a card
    for ii = 1:12
        while IsInRect(mx, my, card{ii})
            cardnum = ii;
            selected = card{ii};
            activeCard;
        end
    end

end
