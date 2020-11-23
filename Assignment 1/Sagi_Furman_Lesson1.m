% create a 3-by-8 matrix of consecutive numbers and transpose it.
% transpose - flip matrix along diagonal axis
B = [1:8; 9:16; 17:24]';

% take the third column vector and put it under the second, using
% semi-colon
V_a = [B(:,2); B(:,3)];

% take the 2nd to 5th elements of the third column vector and add to it the
% transposed last row
V_b = [B(2:5,3); B(end,:)'];

% create a 3-by-3 matrix from the 2nd, 4th and 6th rows.
% convert the matrix into a row vector using the function mat2vec (found in
% the website 'MathWorks'), then transpose it.
V_c = mat2vec(B(2:2:6,:))';

% create a 2-by-2 matrix of zeros and put it together with a two element
% column vector of ones
M_a = [zeros(2) ones(2,1)];

% create a 1-by-3 row vector of ones and merge under it a 3-by-3 eye matrix
M_b = [ones(1,3); eye(3)];

% create a temporary 3-by-3 eye matrix for later use
M_c_temp = eye(3);
% merge in a row 2-by-2 zeros and ones matrices, then under it merge a
% column vector of zeros and the temporary matrix from the last column to
% the first
M_c = [zeros(2) ones(2); zeros(3,1) M_c_temp(:,end:-1:1)];
