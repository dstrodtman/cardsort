try
    setup; % Debugged, solid -- needs edit after touchscreen
    stimuli; % Should pre-establish every stimuli for the entire test
    begin; % Display begin message
    for trialNum = 1:3 %Just testing
        %Set this as the index
        this = presentOrder(trialNum);
%         this = trialNum; %Testing!
        stringId{this,12} = trialNum; %record presentation order
        varAssign;
        complete = 0;
        proceed = 0;
        trial; %Initiate trial
    end
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