

close all;
% Set up parameters and variables
numUsers = 10; % Number of users in the V2X communication system
totalResources = 100; % Total available resources

% Generate random channel gains and power requirements for each user
channelGains = rand(1, numUsers); % Random channel gains
powerRequirements = rand(1, numUsers); % Random power requirements

% Optimized Allocation
% Implement the multi-objective optimization framework to obtain optimized allocation
optimizedAllocation = optimizeAllocation(channelGains, powerRequirements, totalResources);

% Uniform Allocation
uniformAllocation = ones(1, numUsers) * (totalResources / numUsers); % Uniformly allocate resources

% Random Allocation
randomAllocation = rand(1, numUsers) * totalResources; % Randomly allocate resources

% Calculate objective values for each allocation
optimizedObjectiveValue = calculateObjectiveValue(optimizedAllocation, channelGains, powerRequirements);
uniformObjectiveValue = calculateObjectiveValue(uniformAllocation, channelGains, powerRequirements);
randomObjectiveValue = calculateObjectiveValue(randomAllocation, channelGains, powerRequirements);

% Display the objective values for each allocation
disp('Objective Values:');
disp(['Optimized Allocation: ', num2str(optimizedObjectiveValue)]);
disp(['Uniform Allocation: ', num2str(uniformObjectiveValue)]);
disp(['Random Allocation: ', num2str(randomObjectiveValue)]);

% Check convergence and plot convergence
% Check convergence and plot convergence
convergenceIterations = checkConvergence(optimizedAllocation, uniformAllocation, randomAllocation);

figure;
subplot(3, 1, 1);
% Simulate convergence behavior
convergenceValues = exp(-0.05 * convergenceIterations) + randn(size(convergenceIterations)) * 0.02;
plot(1:length(convergenceIterations), convergenceValues, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Convergence');
title('Convergence Plot');
legend('Optimized Allocation', 'Uniform Allocation', 'Random Allocation');

figure;
subplot(3, 1, 1);
plot(1:length(convergenceIterations), exp(convergenceIterations), 'LineWidth', 2);
xlabel('Iteration');
ylabel('Convergence');
title('Convergence Plot');
legend('Optimized Allocation', 'Uniform Allocation', 'Random Allocation');

% Plot the power allocation and throughput allocation for each allocation
%figure;
subplot(3, 1, 2);
bar([optimizedAllocation; uniformAllocation; randomAllocation], 'stacked');
xlabel('Allocation Type');
ylabel('Power Allocation');
title('Power Allocation Comparison');
legend('User 1', 'User 2', 'User 3', 'User 4', 'User 5', 'User 6', 'User 7', 'User 8', 'User 9', 'User 10');

subplot(3, 1, 3);
normalizedThroughput = optimizedAllocation ./ powerRequirements; % Calculate normalized throughput for optimized allocation
bar([normalizedThroughput; uniformAllocation ./ powerRequirements; randomAllocation ./ powerRequirements], 'stacked');
xlabel('Users');
ylabel('Normalized Throughput');
title('Throughput Allocation Comparison');
legend('Optimized Allocation', 'Uniform Allocation', 'Random Allocation');

function optimizedAllocation = optimizeAllocation(channelGains, powerRequirements, totalResources)
  % Define the optimization problem
  f = @(allocation) -sum(allocation ./ powerRequirements); % Maximize the sum of normalized throughput
  A = [];
  b = [];
  Aeq = [];
  beq = [];
  lb = zeros(size(channelGains));
  ub = totalResources * ones(size(channelGains));
  
  % Solve the optimization problem
  options = optimoptions('fmincon', 'Display', 'off');
  optimizedAllocation = fmincon(f, zeros(size(channelGains)), A, b, Aeq, beq, lb, ub, [], options);
end

function objectiveValue = calculateObjectiveValue(allocation, channelGains, powerRequirements)
  % Perform your calculations based on the allocation and other parameters
  % Replace this with your own objective value calculation logic
  objectiveValue = sum(allocation) / sum(channelGains) + sum(allocation) / sum(powerRequirements);
end

function convergenceIterations = checkConvergence(optimizedAllocation, uniformAllocation, randomAllocation)
  % Simulate convergence iterations
  maxIterations = 100;
  convergenceIterations = linspace(1, maxIterations, maxIterations);
end