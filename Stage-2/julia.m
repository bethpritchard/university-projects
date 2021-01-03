%We created a function where you can enter the number of iterations
%and the spacing of the x and y values

%The code works best with somewhere between 50-200 iterations,
%and spacing of 0.001

function julia(nIterations,nSpacing)

% Select the x and y values to iterate between, and the spacing
x = -1.5:nSpacing:1.5; y = -1.25:nSpacing:1.25;

%Creates grid of chosen x-y values
[Xs,Ys] = meshgrid(x,y);

fprintf('Please enter complex number for julia set in the form of A+B*i, between -1<x,y<1: \n');
A=input('A: ');
B=input('B: ');
c=A+B*1i;

out = Xs + 1i*Ys;
            
colour = zeros(size(out));

%Iterates the Mandelbrot function for each point in the grid
for i = 1:nIterations
    out = out.^2+c;
    colour(abs(out)>2 & colour == 0) = nIterations - i;
    
end 

figure();
colormap hot
imagesc(x,y,colour);
    xlabel('x');
    ylabel('iy');
    
end 
