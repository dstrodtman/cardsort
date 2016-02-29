%Make targets unique entities for hover highlight, locking, and data
%tracking. Will later communicate with stimuli info.

% Create cell array for cards
target = cell(1, tarNum);

for ii = 1:tarNum
    target{ii} = finalTarRect(1:4, ii)'; % Define targets
end