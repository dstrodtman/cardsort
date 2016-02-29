%Make cards unique entities for movement commands and data tracking. Will
%later communicate with stimuli info.

% Create cell array for cards
card = cell(1, 12);

for ii = 1:12
    card{ii} = finalCard(1:4, ii)'; % Define cards 1:12
end