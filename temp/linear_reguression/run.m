% test test data
load data.csv

x = data(:, 1)
y = data(:, 2)
plot(x, y)

% random predict
nx = [ones(length(x), 1), x]

function result = predict (theta, x)
  result = x * theta
endfunction

theta = [0; 0.002]
py = predict(theta, nx);
hold off
plot(x, y)
hold on
plot(x, py, 'r')

% know the cost
function result = cost (x, y, theta)
  result = sum((predict(theta, x) - y) .^ 2)
endfunction

v = cost(nx, y, [0; 0.002]);

function plot_cost_function
  theta0_vals = linspace(-10, 10, 100);
  theta1_vals = linspace(-100, 100, 100);

  % initialize J_vals to a matrix of 0's
  J_vals = zeros(length(theta0_vals), length(theta1_vals));

  % Fill out J_vals
  for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
      t = [theta0_vals(i); theta1_vals(j)];    
      J_vals(i,j) = cost(nx, y, t);
    end
  end
  imagesc(theta0_vals, theta1_vals, J_vals);
end

plot_cost_function

% gradient descent
function theta = gradent (theta, a, n, nx, y)
  for i = 1:n,
    i = theta(1, 1) - a * 1/length(nx) * sum( predict(theta, nx) - y )
    j = theta(2, 1) - a * 1/length(nx) * sum( (predict(theta, nx) - y) .* nx(:,2) )
    theta = [i; j]
  end
endfunction

theta = gradent([0; 0], 0.01, 1000, nx, y);

% show result
p = predict(1:length(x), theta)
plot(x, y)
hold on
plot(x, p)
