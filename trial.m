% Basic frame for each trial

% Set initial mouse position to center of screen (where no stimuli are)
SetMouse(xCenter, yCenter, window);

% Offset toggle, to prevent square center snapping to mouse.
offsetSet = 0;

% Set highlight
highlight = 1;

% Draw stimuli to screen
Screen('FillRect', window, 1, tPosit);
Screen('FrameRect', window, .5, tPosit, 5);
Screen('FillRect', window, 1, cell2mat(cPosit')');
Screen('FrameRect', window, .5, cell2mat(cPosit')', 5);

% Draw symbols?
letterDraw;
cardSymbols;

% Set initial active target to the left
activeTar = 1;

% Highlight active target
Screen('FrameRect', window, [0 1 0], tIndie{activeTar}, 5);

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 2; %Provides time for letter draw

% Loop the animation until a key is pressed
while ~complete || ~proceed

    % Get the current position of the mouse
    [mx, my, buttons] = GetMouse(window);

    % See if the mouse cursor is inside a card
    for ii = 1:12
        while IsInRect(mx, my, cPosit{ii})
            cardnum = ii;
            selected = cPosit{ii};
            activeCard;
        end
    end
    
    % Proceed to next
    if complete && IsInRect(mx, my, [0, 0, 100, 100]) && sum(buttons) > 0
        for ii = 1:12
            stringId{this,8}{2,ii} = clicks{ii}; % record clicks
        end
        for ii = 1:tLength
            stringId{this,9}{1,ii} = cSensor{1,ii}(1); % record final card
        end
        proceed = 1;
    end
end
