% Triggers when card is selected

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
    clicks{cardnum} = clicks{cardnum} + 1;
    Click = clicks{cardnum};
    %Record start time
    stringId{this,8}{3, cardnum}(Click) = GetSecs;
    for ii = 1:activeTar
        if IsInRect(sx, sy, tIndie{ii})
            cSensor{2,ii} = 1;
        end
    end
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
        if IsInRect(sx, sy, tIndie{activeTar}) && complete == 0
            [tcx, tcy] = RectCenter(tIndie{activeTar});
            snap = 1;
            stringId{this,8}{4,cardnum}(1,Click) = activeTar;
            cSensor{1,activeTar} = cardnum;
            cSensor{2,activeTar} = 0;
        % Set up snap for previous targets
        elseif snap == 0
            for ii = 1:(activeTar)
                if IsInRect(sx, sy, tIndie{ii})
                    [tcx, tcy] = RectCenter(tIndie{ii});
                    snap = 2;
                    stringId{this,8}{4,cardnum}(1,Click) = ii; %fix this, add again to next section to reassign on reset
                    if cSensor{1,ii} && cSensor{2,ii} == 0
                        cPosit{cSensor{1,ii}} = cReset{cSensor{1,ii}};
                        cCent{cSensor{1,ii}}(1) = cResetX{cSensor{1,ii}};
                        cCent{cSensor{1,ii}}(2) = cResetY{cSensor{1,ii}};
                        cSensor{1,ii} = cardnum; 
                        cSensor{2,ii} = 0;
                    end
                else
                    stringId{this,8}{4,cardnum}(1,Click) = 0;       
                end
            end
        end
    end
    offsetSet = 0; %release offset
end

switch snap
    case 1
        cPosit{cardnum} = CenterRectOnPoint(selected, tcx, tcy);
        snap = 0;
        cCent{cardnum}(1) = tcx;
        cCent{cardnum}(2) = tcy;
        if activeTar < tLength
            activeTar = activeTar + 1;
        else
            highlight = 0;
            complete = 1;
        end
    case 2
        cPosit{cardnum} = CenterRectOnPoint(selected, tcx, tcy);
        cCent{cardnum}(1) = tcx;
        cCent{cardnum}(2) = tcy;
        snap = 0;
    otherwise
        % Center the rectangle on its new screen position
        cPosit{cardnum} = CenterRectOnPointd(selected, sx, sy);
        cCent{cardnum}(1) = sx;
        cCent{cardnum}(2) = sy;
end

% Draw to the screen
Screen('FillRect', window, 1, tPosit);
Screen('FrameRect', window, .5, tPosit, 5);
% Draw symbols (please?)
letterDraw;

Screen('FillRect', window, 1, cell2mat(cPosit')');
Screen('FrameRect', window, .5, cell2mat(cPosit')', 5);
%Draw card symbols
cardSymbols;

% Highlight active target
switch highlight
    case 1
        Screen('FrameRect', window, [0 1 0], tPosit(1:4, activeTar), 5);
end

if complete
    Screen('FillRect', window, [1 0 0], [0, 0, 100, 100]);
    Screen('FrameRect', window, [0 1 0], [0, 0, 100, 100], 5);
end

% Draw active card again to ensure it is on top
Screen('FillRect', window, 1, cPosit{cardnum});
Screen('FrameRect', window, .5, cPosit{cardnum}, 5);
DrawFormattedText(window, cSymbol(cardnum), cCent{cardnum}(1), cCent{cardnum}(2), 0);

% Flip to the screen
vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);