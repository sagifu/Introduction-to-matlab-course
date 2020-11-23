function image = pixleReduction(Image,pix2mean)

n_pix_row = size(Image,1);
n_pix_col = size(Image,2);

n_new_col = ceil(n_pix_col/pix2mean);
n_new_row = ceil(n_pix_row/pix2mean);

image = zeros(n_new_row,n_new_col,size(Image,3));

col_strt = 1;
col_end = pix2mean;
for a = 1:n_new_col
    row_strt = 1;
    row_end = pix2mean;
    for b = 1:n_new_row
        image(b,a,:) = mean(mean(Image(row_strt:row_end,col_strt:col_end,:)));
        
        row_strt = row_strt + pix2mean;
        row_end = row_end + pix2mean;
        
        if row_end > n_pix_row
            row_end = n_pix_row;
        end
    end
    col_strt = col_strt + pix2mean;
    col_end = col_end + pix2mean;
    
    if col_end > n_pix_col
        col_end = n_pix_col;
    end
end

image = uint8(image);