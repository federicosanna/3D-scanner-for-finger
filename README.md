# 3D Scanner for Monitoring Hand Osteoarthritis

Author names:   
Aymeric Peirs   
Quentin Renault   
Federico Sanna   
Mitchell Teal   
Diana Toderita   
Aaron Wright   

Osteoarthritis (OA) is the most common form of joint disease, affecting at least 8 million people in the UK. The most prevalent cases of hand OA affect the distal interphalangeal (DIP) joint of the fingers. Early detection and monitoring of the disease are essential to provide effective treatments. Quantitative and low-cost approaches for tracking the progression of hand OA are not yet available in most clinics. This study introduces a three-dimensional (3D) scanner to reconstruct the morphological features of individual fingers and assess the progression of hand OA. The scanner is composed of 8 cameras attached to a semi-circular ring which acquires pictures of a finger from different angles. Along with processing in MATLAB, this data can be combined to generate a 3D model of the finger. An outline of the finger is obtained from each view through edge detection, and then combined with the others to perform the reconstruction. Some key physiological parameters such as the ratio between the diameter of the DIP joint and the intermediate phalanx, as well as the angle between the phalanges are evaluated. Time for scans was 10.3±0.7s and the points on the surface of the finger were mapped with an accuracy of 0.1mm. The right index of 6 people was scanned 10 times with 2 minutes intervals between measurements, and for each person we obtained a coefficient of variation of less than 1.3%. We achieved the same consistency when testing on a finger simulating the characteristics of OA. The 3D representations obtained accurately represented the fingers, and the results were consistent and repeatable. 3D scanning through edge detection can be an effective and inexpensive way to quantify OA progression, and could be used to deliver more accurate and personalised treatments.

### Acknowledgements

We would like to thank Dr. Angela Kedgley for her supervision and support throughout the year. We would also like to thank Mr. Daniel Nardini, Mr. Paschal Egan and Mr. Niraj Kanabar for giving us guidance in designing and building the prototype.

## Hardware
The glove is made of 4 [short flex sensors](https://www.robotshop.com/uk/1-unidirectional-flexible-bend-sensor.html) (1 inch) and 6 [longer ones](http://www.hobbytronics.co.uk/flex-sensor-2-2) (2.2 inches), 1 [accelerometer](http://www.hobbytronics.co.uk/lsm9ds1-9dof), and 2 [strain gauges](https://www.amazon.co.uk/Hobby-Components-Ltd-BF350-3AA-Strain/dp/B07BF7X4NM/ref=sr_1_4?s=electronics&ie=UTF8&qid=1530872825&sr=1-4&keywords=strain+gauge).

All the sensor have been embedded in a matrix of [silicon](http://www.silex.co.uk/shop/food-grade-silicone-casting-liquid-2-part/c-24/p-13828) to make the structure of the glove.

To connect all the component an Arduino ___ has been used.

Moreover also the following components have been used:
- green LED;
- button;
- 10 x 47kΩ resistors;
- 1 x 10kΩ resistor;
