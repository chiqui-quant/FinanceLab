% Understanding the basics
close all %close all files
clear all %clear all variables
clc %clear shell

% Let's create a vector
v = [12 pi 0];
% Let's print the vector
disp(v);

% We can access elements of the vector
w = v(2);
disp(w);

% Basic operations
v1 = [12 3];
v2 = [4 8];
sum = v1+v2;
disp(sum);

% Scalar multiplication
a = dot(v1,v2);
disp(a);

% Vector multiplication
a = v1.*v2;
disp(a);

% If else
a = 5;
b = 7;
if (a==5)
    fprintf('\na is equal to 5 \n')
else 
    fprintf('\na is not equal to 5 \n')
end

% Note: differently from C there are no brackets
% Let's see other cases
if (a>=5)
    fprintf('\na >= equal to 5 \n')
else 
    fprintf('\na <= equal to 5 \n')
end

% Difference (alt+0126)
if (a~=5)
    fprintf('\na != 5 \n')
else 
    fprintf('\na = 5 \n')
end

% Let's create our first matrix
a = [1 2 3; 4 5 6; 7 8 9];
disp(a);

% Let's access to an element of the matrix (row 2, column 3)
v=a(2,3);
disp(v);

% We can also access more elements (eg. first column)
b = a(:,1);
disp(b);

c = a(2:3,1:2); % from 2nd to 3rd row, from 1st to 2nd column

% Transpose vector
a = [1 2 3];
disp(a);
a = a';
disp(a);

% How to create a matrix using vectors
a = [1 2 3];
b = [4 5 6];
c = [7 8 9];

A = [a;b;c];
disp(A);
% Notice: MatLab is case sensitive (a is different from A)







