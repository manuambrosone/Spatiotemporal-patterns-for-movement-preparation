function motionEnergy_behavior = CalculateMotionEnergyBehaviour(csvFile, selectedROIs)

% Computes behavioural motion energy using the same definition as
% cortical motion energy: sum of squared frame-to-frame differences.
%
% INPUT
%   csvFile     : path to CSV file containing tracking data (e.g. DLC)
%   selectedROIs: cell array of ROI names (e.g. {'eye','whisker'})
%
% OUTPUT
%   motionEnergy : [nROIs x (nFrames-1)] motion energy matrix

    % Load and preprocess CSV
    dataTable = readtable(string(csvFile));

    % Remove frame index column
    dataTable(:,1) = [];

    % Remove likelihood columns (assumed every 3rd column)
    dataTable(:,3:3:end) = [];

    % Convert to numeric matrix
    coords = dataTable{:,:};            % [nFrames x 10]
    coords = reshape(coords', 10, []);  % [10 x nFrames]

    % ROI map (x,y indices)
    roiMap = struct( ...
        'Eye',        1:2, ...
        'Snout',      3:4, ...
        'Whisker',    5:6, ...
        'Right_Forepaw',  7:8, ...
        'Left_Forepaw',  9:10 );

    % Select ROIs
    selectedIdx = [];
    for i = 1:numel(selectedROIs)
        roi = selectedROIs{i};
        if ~isfield(roiMap, roi)
            error('ROI "%s" not found.', roi);
        end
        selectedIdx = [selectedIdx roiMap.(roi)];
    end

    nROIs    = numel(selectedROIs);
    nFrames = size(coords, 2);

    % Initialize output
    motionEnergy_behavior = zeros(nROIs, nFrames-1);

    % Frame-to-frame motion energy
    for r = 1:nROIs

        xIdx = selectedIdx((r-1)*2 + 1);
        yIdx = selectedIdx((r-1)*2 + 2);

        pos = coords([xIdx yIdx], :);   % [2 x nFrames]

        for t = 1:nFrames-1
            diffFrame = pos(:,t+1) - pos(:,t);
            motionEnergy_behavior(r,t) = nansum(diffFrame.^2);
        end
    end

end
