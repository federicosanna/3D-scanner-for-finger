% Reconstruction code for the 3D finger scanner 
% First written: November 2017
% Last modified: June 2018
% Written by:
% Federico Sanna
% Aymeric Peirs
% Quentin Renault
% Mitchell Teal
% Diana Toderita
% Aaron Wright

clc
originalImage1 = imread('img1.jpg');            % Reads a photo from path file  
angle1 = 0;                                       % User input, angle at which photo is taken
originalImage2 = imread('img2.jpg');
angle2 = 22.5;
originalImage3 = imread('img3.jpg');
angle3 = 45;
originalImage4 = imread('img4.jpg');
angle4 = 67.5;
originalImage5 = imread('img5.jpg');
angle5 = 90;
originalImage6 = imread('img6.jpg');
angle6 = 112.5;
originalImage7 = imread('img7.jpg');
angle7 = 135;
originalImage8 = imread('img8.jpg');
angle8 = 157.5;

threshold = ([0.0 0.6]);                        % Threshold value for edge detection
                                                % ATTENTION to set it high enough to pick different skin colours
pixelsToConsiderInLenght = 240;                 % pixels to consider before cutting
                                                % ATTENTION to set it low enought to don't go over the number of pixels


% Edge detection, Rereferencing points and Noise cancelling 
                                                
%Im 1
Contour1 = EdgeDetect(originalImage1, threshold);
nonRotatedPoints1 = ObtainAndReferencePoints(Contour1);
orderedPoints1 = orderOnlyTwoPointsPerSection(nonRotatedPoints1,pixelsToConsiderInLenght);

% Im 2
Contour2 = EdgeDetect(originalImage2, threshold);
nonRotatedPoints2 = ObtainAndReferencePoints(Contour2);
orderedPoints2 = orderOnlyTwoPointsPerSection(nonRotatedPoints2,pixelsToConsiderInLenght);

% Im 3
Contour3 = EdgeDetect(originalImage3, threshold);
nonRotatedPoints3 = ObtainAndReferencePoints(Contour3);
orderedPoints3 = orderOnlyTwoPointsPerSection(nonRotatedPoints3,pixelsToConsiderInLenght);

% Im 4
Contour4 = EdgeDetect(originalImage4, threshold);
nonRotatedPoints4 = ObtainAndReferencePoints(Contour4);
orderedPoints4 = orderOnlyTwoPointsPerSection(nonRotatedPoints4,pixelsToConsiderInLenght);

% Im 5
Contour5 = EdgeDetect(originalImage5, threshold);
nonRotatedPoints5 = ObtainAndReferencePoints(Contour5);
orderedPoints5 = orderOnlyTwoPointsPerSection(nonRotatedPoints5,pixelsToConsiderInLenght);

% Im 6
Contour6 = EdgeDetect(originalImage6, threshold);
nonRotatedPoints6 = ObtainAndReferencePoints(Contour6);
orderedPoints6 = orderOnlyTwoPointsPerSection(nonRotatedPoints6,pixelsToConsiderInLenght);

% Im 7
Contour7 = EdgeDetect(originalImage7, threshold);
nonRotatedPoints7 = ObtainAndReferencePoints(Contour7);
orderedPoints7 = orderOnlyTwoPointsPerSection(nonRotatedPoints7,pixelsToConsiderInLenght);

% Im 8
Contour8 = EdgeDetect(originalImage8, threshold);
nonRotatedPoints8 = ObtainAndReferencePoints(Contour8);
orderedPoints8 = orderOnlyTwoPointsPerSection(nonRotatedPoints8,pixelsToConsiderInLenght);

% Generate centerline and use them to adjust points 

[centerline1, adjustedPoints1, adjustedPoints5] = interpolatePerpendicularProfiles(orderedPoints1, orderedPoints5);
    R = rotx(angle1);                             
    centerline1R = centerline1*R; 
[x_legacy1, y_legacy1, z_legacy1] = RotatePoints(adjustedPoints1, angle1);
[x_legacy5, y_legacy5, z_legacy5] = RotatePoints(adjustedPoints5, angle5);

[centerline2, adjustedPoints2, adjustedPoints6] = interpolatePerpendicularProfiles(orderedPoints2, orderedPoints6);
    R = rotx(angle2);                             
    centerline2R = centerline2*R; 
[x_legacy2, y_legacy2, z_legacy2] = RotatePoints(adjustedPoints2, angle2);
[x_legacy6, y_legacy6, z_legacy6] = RotatePoints(adjustedPoints6, angle6);

[centerline3, adjustedPoints3, adjustedPoints7] = interpolatePerpendicularProfiles(orderedPoints3, orderedPoints7);
    R = rotx(angle3);                             
    centerline3R = centerline3*R; 
[x_legacy3, y_legacy3, z_legacy3] = RotatePoints(adjustedPoints3, angle3);
[x_legacy7, y_legacy7, z_legacy7] = RotatePoints(adjustedPoints7, angle7);

[centerline4, adjustedPoints4, adjustedPoints8] = interpolatePerpendicularProfiles(orderedPoints4, orderedPoints8);
    R = rotx(angle4);                             
    centerline4R = centerline4*R; 
[x_legacy4, y_legacy4, z_legacy4] = RotatePoints(adjustedPoints4, angle4);
[x_legacy8, y_legacy8, z_legacy8] = RotatePoints(adjustedPoints8, angle8);

ratioJointToSectionDiameter = calulateRatio(orderedPoints5);
angle = calculateAngleBtwSecondAndFirstPhalanx(centerline1)

% Plot of the centerlines and the pointcloud

centerline1R = centerline1R(1:201,1:3);
centerline2R = centerline2R(1:201,1:3);
centerline3R = centerline3R(1:201,1:3);
centerline4R = centerline4R(1:201,1:3);
S = repmat([1,1,1],802,1);
s = 1;
figure
plot3(centerline1R(:,1), centerline1R(:,2),centerline1R(:,3))
daspect([1 1 1])
hold on 
plot3(centerline2R(:,1), centerline2R(:,2),centerline2R(:,3))
daspect([1 1 1])
plot3(centerline3R(:,1), centerline3R(:,2),centerline3R(:,3))
daspect([1 1 1])
plot3(centerline4R(:,1), centerline4R(:,2),centerline4R(:,3))
daspect([1 1 1])
scatter3(x_legacy1, y_legacy1,z_legacy1,s,'b','.')
daspect([1 1 1])
scatter3(x_legacy2, y_legacy2,z_legacy2,s,'b','.')
daspect([1 1 1])
scatter3(x_legacy3, y_legacy3,z_legacy3,s,'b','.')
daspect([1 1 1])
scatter3(x_legacy4, y_legacy4,z_legacy4,s,'b','.')
daspect([1 1 1])
scatter3(x_legacy5, y_legacy5,z_legacy5,s,'b','.')
daspect([1 1 1])
scatter3(x_legacy6, y_legacy6,z_legacy6,s,'b','.')
daspect([1 1 1])
scatter3(x_legacy7, y_legacy7,z_legacy7,s,'b','.')
daspect([1 1 1])
scatter3(x_legacy8, y_legacy8,z_legacy8,s,'b','.')
daspect([1 1 1])
hold off

zmin = min(z_legacy3);                          % Returns the lowest point of finger in z axis for future use

% Figure with all the edge detection of the finger

figure
subplot(2,4,1); 
imshow(Contour1)
subplot(2,4,2); 
imshow(Contour2)
subplot(2,4,3); 
imshow(Contour3)
subplot(2,4,4); 
imshow(Contour4)
subplot(2,4,5); 
imshow(Contour5)
subplot(2,4,6); 
imshow(Contour6)
subplot(2,4,7); 
imshow(Contour7)
subplot(2,4,8); 
imshow(Contour8)

% Figure with the 3D reconstruction of finger

figure
funpatch(x_legacy1, y_legacy1, z_legacy1, x_legacy2, y_legacy2, z_legacy2, zmin)
funpatch(x_legacy2, y_legacy2, z_legacy2, x_legacy3, y_legacy3, z_legacy3, zmin)
funpatch(x_legacy3, y_legacy3, z_legacy3, x_legacy4, y_legacy4, z_legacy4, zmin)
funpatch(x_legacy4, y_legacy4, z_legacy4, x_legacy5, y_legacy5, z_legacy5, zmin)
funpatch(x_legacy5, y_legacy5, z_legacy5, x_legacy6, y_legacy6, z_legacy6, zmin)
funpatch(x_legacy6, y_legacy6, z_legacy6, x_legacy7, y_legacy7, z_legacy7, zmin)
funpatch(x_legacy7, y_legacy7, z_legacy7, x_legacy8, y_legacy8, z_legacy8, zmin)

% Final patch
lastpatch(x_legacy1, y_legacy1,z_legacy1, x_legacy8, y_legacy8, z_legacy8, zmin)



function [Contour] = EdgeDetect(originalImage, threshold)
    originalImage1 = rgb2gray(originalImage);      % Converts photo in black and white
    Contour = edge(originalImage1,'Canny', threshold);
end

function [Points] = ObtainAndReferencePoints(Contour)

    [x, y] = find(Contour);                             
    z = zeros(size(x));                             
    Points = [x, y, z];  

    [~, IndxA] = min(x);                            
    Points = global2localcoord(Points','rr',[x(IndxA); y(IndxA); z(IndxA)]);

end

function [x, y, z] = RotatePoints(nonRotatedPoints, angle)

    R = rotx(angle);                             
    nonRotatedPoints = nonRotatedPoints*R;                             

    x = nonRotatedPoints(:,1);                        
    y = nonRotatedPoints(:,2);
    z = nonRotatedPoints(:,3);

end

function [orderedPoints] = orderOnlyTwoPointsPerSection(Points,pixelsToConsiderInLenght)

    % This function takes as input all the points from the picture already in
    % the form of cartesian coordinates and already with global reference to
    % the tip of the finger. 
    % First column must represent proximal distance, second column must
    % represent horizontal position of the profile points of the finger, third
    % column should still be filled with zeros.
    % The output is a 1802x3 matrix of points representing the profile of the
    % finger. 
    % The first column contains proximal distance of the point, second column 
    % represent horizontal position of the profile points of the finger, third
    % column is filled with zeros.
    % It is vital to notice that the points are reordered in the following way:
    % - the points with odd index represent the low profile of the finger, with
    %   negative y values;
    % - the points with even index represent the high profile of the finger, 
    %   with positive y values;

    TPoints = Points';                                  % Transpose the matrix
    x_legacyPre = TPoints(:,1);                         % Legacy values stock x y and z values for future use.
    y_legacyPre = TPoints(:,2);
    % z components left to zero
    orderedPoints = zeros(802,3);                      % Create zero matrix to host ordered values
                                                       % The length has been changed from 1802 to 802
    for goAcrossX = 0:pixelsToConsiderInLenght          % Go across the sections of the finger

        pointsAtSameX = find(x_legacyPre==goAcrossX);   % Find the points on the cross section
        if isempty(pointsAtSameX) == true
            y_max = orderedPoints(2*goAcrossX,2);        % Assign an approximative value to the point if a point is missing
            y_min = orderedPoints(2*goAcrossX-1,2);
        else
            y_max = y_legacyPre(pointsAtSameX(1,1));        % Initialize y_max and y_min
            y_min = y_max;
        end
                                          
        for goAcrossY = 1:length(pointsAtSameX)         % Check for the maximum and minimum value of y in the same cross section
            if y_max <= y_legacyPre(pointsAtSameX(goAcrossY)),y_max = y_legacyPre(pointsAtSameX(goAcrossY)) ; end
            if y_min >= y_legacyPre(pointsAtSameX(goAcrossY)),y_min = y_legacyPre(pointsAtSameX(goAcrossY)) ; end
        end
        orderedPoints(2*goAcrossX+1,1) = goAcrossX;     %copy the x coordinate from old to new matrix
        orderedPoints(2*goAcrossX+2,1) = goAcrossX;
        orderedPoints(2*goAcrossX+1,2) = y_min;         %put the min y coordinate in the odd coordinates
        orderedPoints(2*goAcrossX+2,2) = y_max;         %put the max y coordinate in the even coordinates
    end

end

function [centerline, adjustedPointsSide, adjustedPointsTop] = interpolatePerpendicularProfiles(orderedPointsSide, orderedPointsTop)
    
    adjustedPointsSide = orderedPointsSide;                 % initialize adjusted ordered point and set them equal to 
    adjustedPointsTop = orderedPointsTop;                   % ordered point. Only Z component is going to be changed
    centerline = zeros((length(orderedPointsSide)/2),3);    % Create zero matrix to host ordered values
    for goAcrossX = 1:(length(orderedPointsSide)/2)         % Go across the sections of the finger
         centerline(goAcrossX,1) = goAcrossX;               % Set X component of the centerline
         averageSide = (orderedPointsSide(2*goAcrossX-1,2)+orderedPointsSide(2*goAcrossX,2))/2; % Calculate midpoint of the sideview
         averageTop = (orderedPointsTop(2*goAcrossX-1,2)+orderedPointsTop(2*goAcrossX,2))/2;    % Calculate midpoint of the topview
         centerline(goAcrossX,2) = averageSide;             % Set Y/Z component of the centerline
         centerline(goAcrossX,3) = - averageTop;            % Set Y/Z component of the centerline
         
         adjustedPointsSide(2*goAcrossX-1,3) = - averageTop;   
         adjustedPointsSide(2*goAcrossX,3) = - averageTop;   
         adjustedPointsTop(2*goAcrossX-1,3) = averageSide;   
         adjustedPointsTop(2*goAcrossX,3) = averageSide; 
         
    end

end

function [] = funpatch(x_legacya, y_legacya, z_legacya,x_legacyb, y_legacyb, z_legacyb, zmin)
    x_leg = [x_legacya; x_legacyb];
    y_leg = [y_legacya; y_legacyb];
    z_leg = [z_legacya; z_legacyb];
    legacy = [x_leg, y_leg, z_leg];
    
    faces = zeros((length(x_legacya)-2),4);
    for i = 1:(length(x_legacya)-2)                 %why that -2:if we have 4 rows of points, we will have 3 faces. We have 2 sides, therefor for 8 rows, only 6 faces
        faces(i,:) = [i i+2 length(x_legacya)+i+2 length(x_legacya)+i];
    end
    
    col = (z_leg + abs(zmin));
    p = patch('Faces', faces, 'Vertices', legacy, 'FaceVertexCData',col,'FaceColor','interp');
    
    map = [0 0 1];
    for i = 1:500
        R = i/500;
        G = i/500;
        B = 1;
        a = [R G B];
        map = [map;a];
    end
    for i = 1:500
        R = 1;
        G = (500-i)/500;
        B = (500-i)/500;
        a = [R G B];
        map = [map;a];
    end
    
    p.FaceAlpha = 1;           % remove the transparency
    p.FaceColor = 'interp';    % set the face colors to be interpolated
    p.LineStyle = 'none';      % remove the lines
    colormap(map)
    material shiny
    
    axis equal off
    xlabel('x');
    ylabel('y');
    zlabel('z');
    xlim([0 300]) 
    ylim([-80 80])                                            
end

function [] = lastpatch(x_legacya, y_legacya, z_legacya,x_legacyb, y_legacyb, z_legacyb, zmin)
    x_leg = [x_legacya; x_legacyb];
    y_leg = [y_legacya; y_legacyb];
    z_leg = [z_legacya; z_legacyb];
    legacy = [x_leg, y_leg, z_leg];
    
    faces = zeros((length(x_legacya)-2),4);
    for i = 1:2:(length(x_legacya)-2)                 %set up odd faces
        faces(i,:) = [i i+2 length(x_legacya)+i+3 length(x_legacya)+i+1];
    end
    for i = 2:2:(length(x_legacya)-2)                 %set up even faces
        faces(i,:) = [i i+2 length(x_legacya)+i+1 length(x_legacya)+i-1];
    end
    
    col = (z_leg + abs(zmin));
    p = patch('Faces', faces, 'Vertices', legacy, 'FaceVertexCData',col,'FaceColor','interp');
    
    p.FaceAlpha = 1;           % remove the transparency
    p.FaceColor = 'interp';    % set the face colors to be interpolated
    p.LineStyle = 'none';      % remove the lines
    colormap copper
    material shiny
    xlabel('x');
    ylabel('y');
    zlabel('z');
    %xlim([0 900]) 
    ylim([-80 80])
end

function [ratioJointToSectionDiameter] = calulateRatio(orderedPoints)
    %This function has been added by Federico the day 01/06
    %Allows to have a measure of the swalling of the joints
    %Input: ordered points, which contain what follows:
    %first column: x information (ex. 0,0,1,1,2,2,3,3...)
    %second column: y information (ex. 0,0,-6,9,-10,11...)
    %third column: z information before use of centerlines (ex. 0,0,0,0,0,0,0...)
    %Output: ratio of the biggest diameter in the joint and the smaller
    %diameter in middle phalange
    
    %Estimate of the points corresponding to the area of interest
    startDistalInterphalangeal = 30;
    endDistalInterphalangeal = 140;
    startMiddlePhalanx = 100;
    endMiddlePhalanx = 180;
    maxDiameterDistalInterphalangeal = 0;
    
    %The following is to set a meaningfull minimum diameter that will
    %lately be updated. It is important to have a true value of what the
    %diameter will approx be, and that is what the next 5 lines do
    sum = 0;
    for i = startMiddlePhalanx:(startMiddlePhalanx+3)
        diameter = orderedPoints(2*i,2)-orderedPoints(2*i-1,2);
        sum = diameter + sum;
    end
    minDiameterMiddlePhalanx = sum/4;

    
    for goAcrossX = startDistalInterphalangeal:endDistalInterphalangeal
        diameter = orderedPoints(2*goAcrossX,2)-orderedPoints(2*goAcrossX-1,2);
        if diameter>maxDiameterDistalInterphalangeal
            maxDiameterDistalInterphalangeal = diameter;
        end
    end
    
    for goAcrossX = startMiddlePhalanx:endMiddlePhalanx
        diameter = orderedPoints(2*goAcrossX,2)-orderedPoints(2*goAcrossX-1,2);
        if (diameter<minDiameterMiddlePhalanx) && (diameter>(0.7*minDiameterMiddlePhalanx)) 
            %the AND statement is to ensure that if we have a cross profile section 
            %with only one point it is not goint to updated a false value. 
            %If we have a section with one point only, the diameter
            %calculated will approx be half of a normal one, therefore we
            %screen it by implying that it should be greater than 0.7 the
            %previous minDiameter.
            minDiameterMiddlePhalanx = diameter;
        end   
    end
    
    ratioJointToSectionDiameter = maxDiameterDistalInterphalangeal/minDiameterMiddlePhalanx
end

function [angle] = calculateAngleBtwSecondAndFirstPhalanx(centerline)
    %This function has been added by Federico the day 03/06
    %Calculate the angle between the third and the first phalanges in the
    %finger
    %Input: centerline before rotation
    %first column: x information (ex. 0,1,2,3...)
    %second column: y information, from the side (ex. 0,-6,-10...), ie if
    %we consider the centerline1 generated by camera 1 and 5, this will
    %contain the info from camera 1
    %third column: z information, from the top (ex. 0,5,8,10...)
    %Output: angle in degrees between third and the first phalanges
    
    %Estimate of the points corresponding to the area of interest
    startFirstPhalanx = 20;
    endFirstPhalanx = 70;
    startThirdPhalanx = 140;
    endThirdPhalanx = 180;
    
    %calculate the slope in the first phalanx
    X1 = centerline(startFirstPhalanx:endFirstPhalanx,[1]); %subset of the matrix centerline 
    Z1 = centerline(startFirstPhalanx:endFirstPhalanx,[3]); %subset of the matrix centerline
    plot(X1,Z1,'.b')
    p1 = polyfit(X1,Z1,1);
    f1 = polyval(p1,X1);
    hold on
    plot(X1,f1)
    slopeFirstPhalanx = diff(X1)./diff(f1);
    angleFirstPhalanx = atand(1/slopeFirstPhalanx(5));
    
    %calculate the slope in the third phalanx
    X2 = centerline(startThirdPhalanx:endThirdPhalanx,[1]); %subset of the matrix centerline 
    Z2 = centerline(startThirdPhalanx:endThirdPhalanx,[3]); %subset of the matrix centerline 
    plot(X2,Z2,'.b')
    p2 = polyfit(X2,Z2,1);
    f2 = polyval(p2,X2);
    plot(X2,f2)
    slopeThirdPhalanx = diff(X2)./diff(f2);
    angleThirdPhalanx = atand(1/slopeThirdPhalanx(5));
    
    angle = angleFirstPhalanx - angleThirdPhalanx;
end
