try
    setup;
    tarRect;
    cardGen;
    idCards;
    moveCard;
catch ME
    sca;
    ListenChar(0);
    throw(ME)
end

% Allows key presses to again enter the command window
% If no key presses are registering, Ctrl+C
ListenChar(0);

% Show cursor (uncomment with touch screen)
% ShowCursor;

sca;