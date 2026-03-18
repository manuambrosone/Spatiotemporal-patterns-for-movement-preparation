function motionEnergy_cortex = CalculateMotionEnergyCortical(inputDff)

% Computes motion energy from cortical activity (ΔF/F) as the
% sum of squared frame-to-frame differences.
%
% INPUT
%   inputData : 
%       - 3D matrix (X x Y x T) containing cortical activity, OR
%       - path to a .mat file containing a variable named 'dff'
%
% OUTPUT
%   motionEnergy_cortex : 1 x (T-1) vector of motion energy values

    % Load data if a file path is provided
    if ischar(inputDff) || isstring(inputDff)
        loadedData = load(inputDff);

        if ~isfield(loadedData, 'dff')
            error('The MAT file must contain a variable named "dff".');
        end

        dff = loadedData.dff;
    else
        dff = inputDff;
    end

    % Get number of time points
    T = size(dff, 3);

    % Preallocate output
    motionEnergy_cortex = zeros(1, T-1);

    % Frame-to-frame motion energy computation
    for t = 1:T-1
        diffFrame = dff(:,:,t+1) - dff(:,:,t);
        motionEnergy_cortex(t) = nansum(diffFrame(:).^2);
    end

end

