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

## Hardware
The mechanical design of the final prototype consists of:

- A ring supporting eight cameras
- A hand/wrist support
- Support components: baseboard,  back plate,  two support blocks attached to the ring
- A poster board
- Eight camera attachment pieces
- An LED lighting strip  

![device image](https://user-images.githubusercontent.com/30337324/46888339-1c2daf00-ce58-11e8-977d-ef0945778a79.jpg)
