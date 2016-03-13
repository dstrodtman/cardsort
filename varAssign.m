% Assign variable names for easier management

tName = stringId{this,1}; %Target string
tLength = stringId{this,2}; %Number of targets
tSymbol = stringId{this,3}; %Target symbols
dupes = stringId{this,4}; %Duplicate symbols
tPosit = stringId{this,5}; %Target coordinates
tIndie = stringId{this,6}; %Independent targets
tCent = stringId{this,11}; %Target centers
cSensor = stringId{this,9}; %Detects card placement

cPosit = stringId{this,7}; %Current card position
cReset = stringId{this,7};

cResetX = cell(1,12); %Original card X center position
cResetY = cell(1,12); %Original card Y center position
clicks = cell(1,12); %Click counter

% To be added (or separate for recording after?):
cSymbol = zeros(1,12);
for ii = 1:12
    cSymbol(ii) = stringId{this,8}{1,ii}; % Card symbols
    clicks{ii} = 0; % set click counters
    cResetX{ii} = stringId{this,7}{ii}(1) + 70;
    cResetY{ii} = stringId{this,7}{ii}(2) + 50;
end
cCent = stringId{this,10}; % Card centers
% cTimes = stringId{this,8}{3}; % Card times
% tSensor = stringId{this,8}{4}; % Detects target placement
