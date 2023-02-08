# Blob Detection
<p align="center">
  <img width="500" height="400" src="/ButterflyExample.png" />
</p>

## This branch contains UGVLidar instructions for performing autonomous navigation and obstacle avoidance using the Husky Robot for sp22Robot. This includes the instructions for performing all these tasks within Ubuntu and ROS as well as the code to manually move the robot a certain x, y, and theta distance. 
## Hardware Requirements for Navigation and Obstacle Avoidance: 
- 2D RPLidar
- Nvidia Jetson Nano
- Husky Clearpath Robot https://clearpathrobotics.com/husky-unmanned-ground-vehicle-robot/
## Software Requirements for perception
- RViz
- ROS Melodic [Run this command line: sudo apt install ros-melodic-Husky]
- Ubuntu Bionic 18.04

## Approach
### 
Our focus is to generate a map of the space, perform navigation and obstacle avoidance to estimated location, and finally communicate with the ARM team via MQTT to move robot to the target location.

<p align="center">
  <img src="/pipeline.png" />
</p>


## STEPS TO CREATING A MAP OF THE SPACE 
