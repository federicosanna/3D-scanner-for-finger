# 3D Scanner for Monitoring Hand Osteoarthritis

Author names:
Federico Sanna     
Aymeric Peirs   
Quentin Renault   
Mitchell Teal   
Diana Toderita   
Aaron Wright   

Osteoarthritis (OA) is the most common form of joint disease, affecting at least 8 million people in the UK. The most prevalent cases of hand OA affect the distal interphalangeal (DIP) joint of the fingers. Early detection and monitoring of the disease are essential to provide effective treatments. Quantitative and low-cost approaches for tracking the progression of hand OA are not yet available in most clinics. This study introduces a three-dimensional (3D) scanner to reconstruct the morphological features of individual fingers and assess the progression of hand OA. The scanner is composed of 8 cameras attached to a semi-circular ring which acquires pictures of a finger from different angles. Along with processing in MATLAB, this data can be combined to generate a 3D model of the finger. An outline of the finger is obtained from each view through edge detection, and then combined with the others to perform the reconstruction. Some key physiological parameters such as the ratio between the diameter of the DIP joint and the intermediate phalanx, as well as the angle between the phalanges are evaluated. Time for scans was 10.3±0.7s and the points on the surface of the finger were mapped with an accuracy of 0.1mm. The right index of 6 people was scanned 10 times with 2 minutes intervals between measurements, and for each person we obtained a coefficient of variation of less than 1.3%. We achieved the same consistency when testing on a finger simulating the characteristics of OA. The 3D representations obtained accurately represented the fingers, and the results were consistent and repeatable. 3D scanning through edge detection can be an effective and inexpensive way to quantify OA progression, and could be used to deliver more accurate and personalised treatments.

### Acknowledgements

We would like to thank Dr. Angela Kedgley for her supervision and support throughout the year. We would also like to thank Mr. Daniel Nardini, Mr. Paschal Egan and Mr. Niraj Kanabar for giving us guidance in designing and building the prototype.

__**Disclaimer**__ : the following text has been extracted from a more complete report that we produced. Since it was very time consuming to adapt every image/table/text, I have decided to simply report here some pieces, that you might find disconnected. If you are interested in reading the whole report drop me a message and I'll send it to you!!
Enjoy

## Methods

The model of the finger is generated from the interpolation of its outlines, which are captured through eight cameras positioned at different angles on a semi-circular ring. The images are processed in MATLAB to ultimately display a 3D model of the finger, while also providing measurements that are relevant for clinicians monitoring OA. Only one finger at a time may be scanned.


## Hardware
The mechanical design of the final prototype consists of:

- A ring supporting eight cameras
- A hand/wrist support
- Support components: baseboard,  back plate,  two support blocks attached to the ring
- A poster board
- Eight camera attachment pieces
- An LED lighting strip  

![device image](https://user-images.githubusercontent.com/30337324/46888339-1c2daf00-ce58-11e8-977d-ef0945778a79.jpg)

### Camera Calibration

The eight web cameras attached to the ring are connected to the computer via two USB hubs. They have been individually calibrated using Matlab’s built in calibration tool to correct for any lens distortion in the cameras. Using the calibration tool, the individual camera’s intrinsic, extrinsic and distortion parameters are estimated and stored in an object called ‘cameraParams’, which can be called upon to ‘undistort’ the image of interest.

## MATLAB code

### Image Acquisition

The webcams connected to the computer are numbered 1-8, and are prompted to capture and store images of the finger. Each camera takes one picture, which is cropped, rotated and converted to grayscale to be used with the edge detection function. Edge detection has further been improved by placing a black poster board below the finger to provide a homogeneously coloured background. The focus of each webcam was adjusted manually to a distance of approximately 20cm, which is the distance from the cameras to the finger.

### Edge Detection and 3D Reconstruction

From the pictures acquired, the code generates a 3D model of the finger and outputs key physiological parameters that can be used to estimate the progression of  OA.

To improve the efficiency of the scanner, we decided to implement our own algorithm that could meet our specific needs and overall aims. Through edge detection, the outlines of the finger for different angles are obtained. These are converted into coordinate points and their reference frame is modified to have the origin at the tip of the finger, with the x axis pointing proximally, y pointing posteriorly, and z axis pointing laterally (see functions EdgeDetect and ObtainAndReferencePoints).  Everything that is recognised as noise and that does not belong to the outline of the finger is ignored and deleted. From the leftover points, which are the outline of finger, only two points per given x value are kept (for example at x = 50, the coordinate of (50,-28) and (50,39) are kept - previously, there were more than 2 points associated with any given x value). This gives a clearer output for reconstruction and enables higher computational efficiency (see function orderOnlyTwoPointsPerSection).

![orderePointimage](https://user-images.githubusercontent.com/30337324/46890972-6581fc80-ce60-11e8-9743-f4230cf58186.jpg)

Figure above: Points corresponding to the lateral view of the finger. They are referenced with respect to the tip and only two points per section are kept. It can be seen that only the relevant points are kept and noise is minimised. (Units are in points, not mm. In section 4.3.2 the linear correlation between points and mm will be made explicit)

To correctly combine the eight edges of the finger from 2D planes to a 3D model, the edges are interpolated and meshed together.  Each of the four pairs of perpendicular edges are considered separately and in their own coordinate system, meaning that each of the pairs will contain an outline on the x-y plane  and an outline on the x-z plane. Considering one of those pairs, we can compute two centrelines, one for each frame, which represent the medial axis of the outlines. The centrelines, one expressed purely as a function of x-y and the other as a function of x-z, are linearly combined together to get a single centreline as a function of x-y-z. This merged centreline represents the centre of buoyancy for each section of the finger. The z coordinates of the final centreline are used to generate the z coordinates of the outline on the x-y plane, giving it depth in its third dimension, and the same thing is done with the x-z plane (see function interpolatePerpendicularProfiles). The same process is repeated over each pair of outlines, and then they are rotated according to the angle of the camera from which they were taken (see function RotatePoints) to reconstruct the skeleton of the 3D model.

The centerlines are then meshed together to obtain further information on the 3D spatial coordinates of each outline, whose points are modified accordingly. First figure below shows all the centerlines together. Second figure below shows how the outlines are adjusted based on the centerlines.

![allCentreline_Method](https://user-images.githubusercontent.com/30337324/46890979-661a9300-ce60-11e8-9680-84d93b1d27ce.jpg)

![allCentrelineandOutput](https://user-images.githubusercontent.com/30337324/46890977-6581fc80-ce60-11e8-80eb-fc67de01245a.jpg)

### Display 3D model

Once the outlines have been corrected, they are plotted to reconstruct a 3D image by generating small quadrilaterals elements which connect each point on the surface of the finger (see functions funpatch and lastpatch).

![ricostruione dito](https://user-images.githubusercontent.com/30337324/46888337-1b951880-ce58-11e8-84f2-4d88169a5514.jpg)

### Display Joint Angles and data

To give a quantitative measure of physiological parameters of the finger, the program outputs the ratio between the diameter of the DIP joint and that of the intermediate phalanx, as well as the angle between the intermediate and distal phalanges.

The eight images associated with different angles around the finger can be used to obtain these parameters, such that perspective dependent values can be obtained. The program is also able to measure the average diameter of the finger at any section, for a given distance from the fingertip (see function calulateRatio).

The angle between the distal and proximal phalanges is calculated by finding the line of best fit (linear) of the centerlines that represent the two phalanges and evaluating the angles between these lines (see function calculateAngleBtwThirdAndFirstPhalanx).

![angle_putInMethodSec](https://user-images.githubusercontent.com/30337324/46890975-6581fc80-ce60-11e8-8eee-6d6eb4fab9b2.jpg)

Figure above:  Lines of best fit on the centerline. Blue line represents the line of best fit for the centerline of the distal phalanx. Red line represents the line of best fit for the centerline of the intermediate phalanx. Note that the scale of the two axis is not the same to highlight the difference in the angles. The angle of the finger results in a value of 8.89°.

### Graphical User Interface (GUI)

In order to make the scanner software easier to use for clinicians, a GUI was created. It consisted of 2 buttons, ‘Aquire Images’ and ‘Display Model’.

The output looks something like this:

![output image](https://user-images.githubusercontent.com/30337324/46888338-1b951880-ce58-11e8-9614-f9a22360058f.JPG)

## Results

For all the results in this section, the scanned object was removed from the device and reinserted in between each scan. This was done to simulate clinical conditions.

### Timescale of the scan

Experimental setup: The image acquisition code was run ten times and the duration of each scan was recorded using the MATLAB function ‘tic-toc’. The average duration of scans was calculated to be 10.3 seconds, with a standard deviation of 0.71 seconds.

### Qualitative validity of the device

Experimental setup: We scanned and 3D reconstructed the right index fingers of the six group project members. The output of the code was compared to the original photos of the fingers.

### Quantitative Tests

Device accuracy

The accuracy of the device can be quantified by scanning a cylinder of known dimensions and comparing it with the 3D reconstruction
Experimental setup: A 12.55 mm diameter cylinder was scanned and reconstructed 5 times. The x, y, z coordinates of the obtained edges were exported from MATLAB as a .xlsx (Excel) file. This was then saved as a .txt (tab delimited file) and imported into Geomagic Studio 12 (3D Systems, North Carolina, US, referred to as ‘Geomagic’) where the 3D representation of the cylinder could be analysed.
The cross sections of the scans were analysed at 26mm from the tip, as this is approximately the distance between the tip of the finger and the DIP joint, and it is therefore where we want the highest accuracy. This cross section was then compared to a perfect circle of diameter 12.55mm. The cross section contained 16 points as the scan was taken with 8 cameras. For each point of the reconstruction’s cross section, the smallest distance between the point and the ideal circle was recorded. This analysis was performed for five different scans of the same cylinder.

![new12](https://user-images.githubusercontent.com/30337324/46890973-6581fc80-ce60-11e8-8da5-8653b8102480.jpg)

The average distance between points in the cross section and the ideal circle was 0.097mm over the five tests. The average standard deviation of these points was 0.1mm.

Linearity of Measurements

Experimental setup: Four cylinders of varying diameters (8.13mm, 10.7mm, 12.55mm and 20.83mm respectively) were scanned 5 times. Figure # shows the apparatus used for this test. The coordinates of the edges obtained in MATLAB were imported into Geomagic in order to measure the output diameter of each edge. The aim of the experiment was to obtain a relationship between the actual diameter and the diameter in the coordinate system of MATLAB, which is directly related to the pixels of the images. Applying a linear regression to the data, we obtain a line of slope 3.8656 with a coefficient of determination of 0.9988.

Accuracy of the Angle and Ratio functions.

For a perfect cylinder, the joint angles and physiological ratios should respectively yield 0° and 1. In this section we will verify this measure of the device’s accuracy.
Experimental Setup: Scan a cylinder 10 times and record values of joint angle and nodal ratios (the ratio between the diameter of the DIP joint and that of the intermediate phalanx).
Results: the mean of the ratios are both 1.02 with standard deviations of 0.01. The joint angle output is -0.09° with a standard deviation of 0.41°.

##	Discussion
Having built the 3D scanner following the steps we detailed in the methods section, we then tested various characteristics of the device and quantified its accuracy, precision and repeatability.
### Overall reliability

Timescale results

One of the requirements of our device was a consistently short scan time. Our results show an average scan time of 10.3 seconds, meaning that a hand can theoretically be scanned in under a minute. This is a short enough time to avoid causing significant discomfort for a patient whilst the scan is underway. Additionally, the values for the time of repeated scans do not have a large dispersion, with a standard deviation of 0.71 seconds. The prototype satisfies our initial requirements for a scanning time below 30 seconds.

Qualitative analysis of the scanning results

From the figures ## in results section 4.2. It is evident that our code provides a realistic reconstruction of a scanned finger in MATLAB. These images demonstrate that the code is proficient at picking up on protrusions of the skin, curvatures of the finger, thickness along the length of the finger, and accurately depicting the outline of the finger. This is helpful in determining morphological changes of the finger caused by OA. The person responsible for analyzing the results of a scan will be able to look at images side-by-side from different time points, and directly see if there are characteristic distinctions worth noting.

Accuracy tests

From section 4.3.1, we observe that when scanning a cylinder, the cross section of the reconstruction resembles a circle. Upon inspection of the data in table ##, it is clear that the errors in the radial direction are much less than our target of +/-0.5mm. The average of the error across all five tests is 0.097mm, with a maximum error of 0.435mm. Furthermore, the distribution of the errors with respect to the distances resembles a Poisson’s distribution. This suggests that we have achieved our accuracy target.
This precision in the radial direction enables our prototype to measure accurately the formation of Heberden’s node in patients suffering from OA.
We determined that there was a linear relationship between the dimensions of a real-world object and its dimensions as represented in Geomagic. In addition, the measurements proved to be equally accurate across the range of diameters, as shown in the coefficient of variation values in table ##. We must keep in mind that this linearity holds for a range of values similar to that of a finger (8 - 20 mm) but could be nonlinear for other diameters. In practice, this means the dimensions of a scanned object are 3.8656 times larger in Geomagic.
Looking at the results, we observe that both the horizontal and vertical ratios for a perfect cylinder are 1.02, and the angle is -0.09°. Both of these measurements were obtained with very small standard deviations of <0.01 and <0.5° respectively. We would expect a perfect cylinder to have ratios of 1.00 and an angle of 0°. The difference between experiments and theory could be due to misalignment of the cameras with the finger and imperfections in the diameter of the cylinder. Nonetheless, this suggests that our functions for generating the ratios and joint angle are both precise and accurate.

Repeatability tests

The results from section 4.4 quantify the consistency of the scanner. We can see that the horizontal ratio, vertical ratio and angle are almost unchanged among the 10 trial scans as seen by the standard deviations of these values. The largest standard deviation for the horizontal and vertical ratios, and angle respectively are: 0.014, 0.015 and 0.955°. These values suggest that the clinician can be fairly confident in the results of individual scans over a specific time period. If instructed properly, it is reasonable to assume that patients will be consistent in the way that they place their finger in the scanner over the course of multiple appointments.

Validation Tests

In our experiments to validate diagnostic accuracy on a finger with a simulated swelling, we obtained a mean horizontal ratio of 1.23 and a mean vertical ratio of 1.06, as shown in table #. Comparing these results to those of a normal finger (table #), we observe the vertical ratio remains virtually unchanged (1.054 before vs. 1.06 after). However, the horizontal ratio has increased from 1.073 to 1.23 which represents a change of +14.6%. This is the increase we would expect given the blu-tack has only added to the horizontal dimension of Quentin’s finger. For the cylinder mimicking a deviated phalanx, we observed a significant angle of deviation of 22.08°.
These outputs mean that we can quantitatively compare scans at different times to monitor the progress of OA. They also allow the design of better fitting splints to help relieve symptoms of OA. Additionally, because we are no longer using manual techniques, there is no error due to human interpretation.

Limitations

Our prototype could be used to monitor OA in the interphalangeal joint of the thumb, but not in the metacarpophalangeal or carpometacarpal joints. This is mainly due to the fact that these joints are obstructed by the hand in several of our camera angles. This is one part of our design where there is room for improvement.
The timescale of the scanning could also be reduced by several seconds if the computing power of the PC is increased. Additionally, with higher computing capabilities and better cameras we could also increase the resolution of the 3D image. More cameras would also increase the number of edges and the accuracy of the reconstruction.
To operate the device it is necessary to turn the LEDs on, open Matlab and run the program. There are few steps to obtain results and the steps involve simple actions, the highest level of difficulty residing in running the Matlab code.

Bill of Materials

Our scanner cost approximately £275 for the materials. A full breakdown of costs is shown in Appendix #. This is 20 times less expensive than the EinScan Pro+ and is therefore in line with our aim of creating a low-cost device. However, the softwares required for the running of the scanner and the interpretation of results are expensive. Together, licenses for MATLAB and Geomagic can cost thousands of pounds, which would negate the low cost of the materials.

### Comparison of results with literature

Comparison with Mussett’s paper

The IR scanning device described in Mussett’s MRes paper was tested on multiple cylinders with varying diameters, similarly to the tests we conducted. The errors that Mussett obtained when measuring the diameter of 10mm and 20mm rods were up to 42.5mm. In the same range of test cylinders, our diameter values have a range of 0.2mm which is substantially better. Additionally, our device has a scan time 60 times shorter and determines the alignment of the DIP joint without the use of a marker.
Mussett’s device was required to run without a PC connection and that requirement was fulfilled. Our device however requires a PC connection to run. This is also a path for improvement.

Compare with other papers

We also achieved a shorter scan time than Karakashian et al. [13], who used a 3D depth sensing camera to analyse the shape of an arm. Their scan time ranged from 20 to 30 seconds, which is up to 3 times greater than our timescale for an individual finger.

Future work

As explained earlier, further improvements could be done to better align the cameras with respect to the finger. The drilling of the holes to attach the webcam supports to the support ring and the bending of the ring were both  performed manually. If we were to use Computer Aided Manufacture (CAM), we could achieve smaller tolerances when performing these operations which would allow us to better align the webcams and reduce distortion.
Further testing on patients affected by OA can be a useful tool to establish the other possible limitations of our prototype. To monitor OA in patients in the long term, the device would also have to take values and store them under specific folders representing patient profiles. Further coding would help create a user friendly interface on which a patient record can be stored. Similarly, it would be accessible by the GP who will have access to the data for each patient.
A solution to reduce the costs and to achieve a closed loop system (no PC connection required) would be to write code in another language such as Arduino or Raspberry Pi. However, without being able to use the pre-built functions in Matlab, it is unlikely we would be able to write this code by ourselves.

##	Conclusion

The current methods of monitoring OA progression are time costly and could be accomplished in a more effective manner. This study has shown that using edge detection as a 3D scanning technique can be an effective way to provide fast, reliable and low-cost monitoring for the fingers of patients suffering from hand OA. With an increase in the number of cameras, as well as some minor modifications to the reconstruction code, the prototype could be installed and used in clinics as well as in GP surgeries to provide a quantitative analytical support in the supervision of the disease.
