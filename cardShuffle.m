% Randomizes order of cards for card bank

%Seed bank
seeds = 'ABCDEFGHIJ';

%Add duplicates
bank = horzcat(seeds, stringId{ii,4});

%Check length, add to fill empties
if length(bank)<12
    extra = 12 - length(bank);
    % Permute seed and fill in bank
    picker = randperm(10);
    filler = seeds(picker(1:extra));
    bank = horzcat(bank,filler);
end

%Create truly random permutation of card bank
cardOrder = randperm(12);

%Shuffle cards
bank = bank(cardOrder(1:12));