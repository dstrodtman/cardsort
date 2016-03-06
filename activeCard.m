% Set snap
snap = 0;

% Get the current position of the mouse
[mx, my, buttons] = GetMouse(window);

% Find the central position of active card
[cx, cy] = RectCenter(selected);
sx = cx;
sy = cy;

% If the mouse cursor is inside the card and a mouse button is being
% pressed and the offset has not been set, set the offset and signal
% that it has been set
if sum(buttons) > 0 && offsetSet == 0
    dx = mx - cx;
    dy = my - cy;
    offsetSet = 1;
    % Increment click counter
    stringId{this,8}{2, cardnum} = stringId{this,8}{2, cardnum} + 1;
    Click = stringId{this,8}{2, cardnum};
    %Record start time
    stringId{this,8}{3, cardnum}(Click, 1) = GetSecs;
end

% If we are clicking on the card allow its position to be modified by
% moving the mouse, correcting for the offset between the centre of the
% card and the mouse position
if sum(buttons) > 0
    sx = mx - dx;
    sy = my - dy; 
end

% Set up a switch for target stimuli to snap to
if sum(buttons) <= 0 %fixes GPU complaints
    if offsetSet == 1
        %Record end time
        stringId{this,8}{3, cardnum}(Click, 2) = GetSecs;
        if IsInRect(sx, sy, stringId{this,6}{activeTar})
            [tcx, tcy] = RectCenter(stringId{this,6}{activeTar});
            snap = 1;
        end
        
    end
    offsetSet = 0; %release offset
end

switch snap
    case 1
        stringId{this,7}{cardnum} = CenterRectOnPoint(selected, tcx, tcy);
        snap = 0;
        activeTar = activeTar + 1;
        if activeTar > stringId{this,2}
            complete = 1;
            activeTar = 0;
        end
    otherwise
        % Center the rectangle on its new screen position
        stringId{this,7}{cardnum} = CenterRectOnPointd(selected, sx, sy);
end

% Draw to the screen
Screen('FillRect', window, 1, stringId{this,5});
Screen('FrameRect', window, .5, stringId{this,5}, 5);
Screen('FillRect', window, 1, cell2mat(stringId{this,7}')');
Screen('FrameRect', window, .5, cell2mat(stringId{this,7}')', 5);

% Highlight active target
if activeTar > 0
    Screen('FrameRect', window, [0 1 0], stringId{this,5}(1:4, activeTar), 5);
end

if complete
    Screen('FillRect', window, [1 0 0], [0, 0, 100, 100]);
    Screen('FrameRect', window, [0 1 0], [0, 0, 100, 100], 5);
end

% Draw active card again to ensure it is on top
Screen('FillRect', window, 1, stringId{this,7}{cardnum});
Screen('FrameRect', window, .5, stringId{this,7}{cardnum}, 5);

% Flip to the screen
vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);