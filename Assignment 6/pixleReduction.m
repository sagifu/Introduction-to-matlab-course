function image = pixleReduction(Image,pix2mean)
% function pixleReduction recieves an image and a scalar, and reduces the
% image clarity
% INPUT: - Image - 3 dimensional array (RGB image)
%        - pix2mean - a scalar indicating the square size of pixels that
%        will be calculated into one pixel
% OUTPUT: - image - input Image after reduction

% extract number of rows and columns
n_pix_row = size(Image,1);
n_pix_col = size(Image,2);

% calculate number of rows and columns in the new picture
% if the original number of rows/columns doesn't divide in the number of
% pixel reduction, round up using ceil
n_new_col = ceil(n_pix_col/pix2mean);
n_new_row = ceil(n_pix_row/pix2mean);

% allocate output variable
image = zeros(n_new_row,n_new_col,size(Image,3));

% column counters
col_strt = 1;
col_end = pix2mean;
% loop over NEW image column size
for a = 1:n_new_col
    % row counters reset
    row_strt = 1;
    row_end = pix2mean;
    % loop over NEW image row size
    for b = 1:n_new_row
        % calculate the mean of input Image pixels
        image(b,a,:) = mean(mean(Image(row_strt:row_end,col_strt:col_end,:)));
        
        % advance counters
        row_strt = row_strt + pix2mean;
        row_end = row_end + pix2mean;
        
        % make sure the last value isn't greater than the input Image
        % dimnsions
        if row_end > n_pix_row
            row_end = n_pix_row;
        end
    end
    % advance counters
    col_strt = col_strt + pix2mean;
    col_end = col_end + pix2mean;
    
    % make sure the last value isn't greater than the input Image
    % dimnsions
    if col_end > n_pix_col
        col_end = n_pix_col;
    end
end
% return output image in uint8 format
image = uint8(image);