function thresholded = susan_threshold(image,threshold)
% ���ܣ��趨SUSAN�㷨����ֵ

[a b]=size(image);
intensity_center = image((a+1)/2,(b+1)/2);
 
temp1 = (image-intensity_center)/threshold;
temp2 = temp1.^6;
thresholded = exp(-1*temp2);
