%We created a function where you can enter the number of iterations
%and the spacing of the x and y values

%The code works best with somewhere between 20-100 iterations,
%and spacing of 0.001

function mandelbrot(nIterations,nSpacing)

% Select the x and y values to iterate between, and the spacing
x = -2:nSpacing:0.5; y = -1.25:nSpacing:1.25;

%Creates grid of chosen x-y values
[Xs,Ys] = meshgrid(x,y);

c = single(Xs + 1j * Ys);

out = c;
colour = zeros(size(out));

tic %timer

%Iterates the Mandelbrot function for each point in the grid
for i = 1:nIterations
    out = out.^2+c;
    colour(abs(out)>2 & colour == 0) = nIterations - i;
    
end 

toc

%plots the Mandelbrot set 
figure();

colormap hot
imagesc(x,y,colour);
    xlabel('x');
    ylabel('iy');
end 

