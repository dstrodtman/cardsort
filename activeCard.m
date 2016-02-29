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
    for ii = 1:tarNum
        if IsInRect(sx, sy, target{ii})
            [tcx, tcy] = RectCenter(target{ii});
            snap = 1;
        end
    end
end

switch snap
    case 1
        card{cardnum} = CenterRectOnPoint(selected, tcx, tcy);
        snap = 0;
    otherwise
        % Center the rectangle on its new screen position
        card{cardnum} = CenterRectOnPointd(selected, sx, sy);
end

% Draw to the screen
Screen('FillRect', window, 1, finalTarRect);
Screen('FrameRect', window, .5, finalTarRect, 5);
Screen('FillRect', window, 1, cell2mat(card')');
Screen('FrameRect', window, .5, cell2mat(card')', 5);

% Draw active card again to ensure it is on top
Screen('FillRect', window, 1, card{cardnum});
Screen('FrameRect', window, .5, card{cardnum}, 5);

% Flip to the screen
vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

% Check to see if the mouse button has been released and if so reset
% the offset cue
if sum(buttons) <= 0
    offsetSet = 0;
end
