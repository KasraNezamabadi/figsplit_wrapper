function separateit_second(BW, startpointy, endpointy, startpointx, endpointx, wholeheight,wholewidth)
%separateit(BW, startpointy, endpointy, startpointx, endpointx)
%separateit(panels, locs90(l), locs90(l+1),locs0(i),locs0(i+1))
    global panelsnum;
    global storepanels;
    [height, width]=size(BW);
    longimage=0;
    bigimage=0;
    if height/width>3 || width/height>3
        longimage=1;
    end
    if height*width*4>wholeheight*wholewidth
        bigimage=1;
    end
    wholearea=wholeheight*wholewidth;
    hist0degree=zeros(width,1);
    hist90degree=zeros(height,1);
    locs0=[];
    locs90=[];

    if width>wholewidth/10
        
    for i=1:width
        hist0degree(i)=sum(BW(:,i));
    end

    [pks0, locs0, w0, p0]=findpeaks(hist0degree,'MinPeakHeight',0.9*height,'MinPeakDistance',wholewidth/12);   
    
   if length(locs0)>5
     
    [pks0, locs0, w0, p0]=findpeaks(hist0degree,'MinPeakHeight',0.95*height,'MinPeakDistance',wholewidth/12);  
   
   end
    
   if longimage>0 && isempty(locs0) && bigimage>0
       [pks0, locs0, w0, p0]=findpeaks(hist0degree,'MinPeakHeight',0.85*height,'MinPeakDistance',wholewidth/12);
        if isempty(locs0)
            [pks0, locs0, w0, p0]=findpeaks(hist0degree,'MinPeakHeight',0.75*height,'MinPeakDistance',wholewidth/12);
            
        end
   end
    
   
    end

    if isempty(locs0)
        locs0=[1;locs0];
    end
    
    if locs0(1)>wholewidth/10
        locs0=[1;locs0];
    
    end
    
    if locs0(length(locs0))<(width-wholewidth/10)
        locs0=[locs0;width];
    end
    
    
    % Find the points to seperate in horizontal level.

    if height>wholeheight/10
    for i=1:height
        hist90degree(i)=sum(BW(i,:));
    end
    
    [pks90,locs90, w90, p90]=findpeaks(hist90degree,'MinPeakHeight',0.9*width,'MinPeakDistance',wholeheight/12);
    
    if length(locs90)>5
        [pks90, locs90, w90, p90]=findpeaks(hist90degree,'MinPeakHeight',0.95*width,'MinPeakDistance',wholeheight/12);
        
    end
    
    if longimage>0 && isempty(locs90) && bigimage>0
        [pks90,locs90, w90, p90]=findpeaks(hist90degree,'MinPeakHeight',0.85*width,'MinPeakDistance',wholeheight/12);
        
        if isempty(locs90)
            [pks90, locs90, w90, p90]=findpeaks(hist90degree,'MinPeakHeight',0.75*width,'MinPeakDistance',wholeheight/12);
            
        end
    end
    
    
    end
    
    
    if isempty(locs90)
        locs90=[1;locs90];
    end
    if locs90(1)>wholeheight/10
        locs90=[1;locs90];
    
    end
    if locs90(length(locs90))<(height-wholeheight/10)
        locs90=[locs90;height];
    end
% Find the separation in vertical level.

worknum=0;


if length(locs0)<=2 && length(locs90)<=2
    addflag=1;
    for i=1:size(storepanels,1)
        overlapratio= bboxOverlapRatio(storepanels(i,:),[startpointx, startpointy, width, height],'Min');
        if overlapratio>0.1
            addflag=0;
        end
    end
    if addflag==1
    storepanels=[storepanels;startpointx, startpointy, width, height];
    panelsnum=panelsnum+1;
    worknum=1;
    end
    
end

locs0backup=locs0;
locs90backup=locs90;
worknum=0;

if length(locs0)>2 || length(locs90)>2  
    for i=1:(length(locs0)-1)
    for l=1:(length(locs90)-1)
       if (locs90(l+1)-locs90(l))*(locs0(i+1)-locs0(i))>wholearea/30
           
                addflag=1;
                for p=1:size(storepanels,1)
                    overlapratio= bboxOverlapRatio(storepanels(p,:),[startpointx+locs0(i), startpointy+locs90(l), locs0(i+1)-locs0(i), locs90(l+1)-locs90(l)],'Min');
                     if overlapratio>0.1
                        addflag=0;
                     end
                 end
                if addflag==1
                    storepanels=[storepanels;startpointx+locs0(i), startpointy+locs90(l), locs0(i+1)-locs0(i), locs90(l+1)-locs90(l)];
                    panelsnum=panelsnum+1; 
                    worknum=1;
                end
       end
    end
    
    end    
    
end

if worknum==0
    storepanels=[storepanels;startpointx, startpointy, width, height];
    panelsnum=panelsnum+1;
end
