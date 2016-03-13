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