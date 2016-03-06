% This is my first program with Psychtoolbox. I've borrowed heavily from
% various tutorials from around the web, but the summative project is
% original (and still a work in progress).

% Clear the workspace and the screen
sca;
close all;
clearvars;

% Call  default settings
PsychDefaultSetup(2);

% Prevent key presses from entering command window
% If no key presses are registering, Ctrl+C
ListenChar(2);

% Hide cursor (uncomment after adding touchscreen)
% HideCursor;

% Get the screen numbers. Set to draw to external screen, if available.
screens = Screen('Screens');
screenNumber = max(screens);

% Open a window (on selected monitor) and color it black.
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, 0);

% Get the size of the on screen window in pixels
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the center coordinate of the window in pixels
[xCenter, yCenter] = RectCenter(windowRect);

% Enable alpha blending for anti-aliasing
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% Retreive the maximum priority number and set max priority
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% Measure the vertical refresh rate of the monitor
ifi = Screen('GetFlipInterval', window);

% Setup the text type for the window
Screen('TextFont', window, 'Arial');
Screen('TextSize', window, 50);

% Print prompt to window
textString = 'Click mouse to begin'; % 'Touch screen to begin' in future

DrawFormattedText(window, textString, 'center', 'center', 1);
Screen('Flip', window);

% Wait for mouse click
[x,y,buttons] = GetMouse;
while any(buttons) % if already down, wait for release
    [x,y,buttons] = GetMouse;
end
while ~any(buttons) % wait for press
  [x,y,buttons] = GetMouse;
end
while any(buttons) % wait for release
  [x,y,buttons] = GetMouse;
end
