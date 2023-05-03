<p align="center">
  <img width = "100%" src='res/BARN_Challenge.png' />
  </p>

--------------------------------------------------------------------------------

# ICRA 2023 BARN Challenge
## Solution
* New package "tps_astar" is the project that will be used to solve the challenge. 
```
  catkin_create_pkg tps_astar std_msgs roscpp rospy tf sensor_msgs
```
* Create submodule for the underlying algorithm library
```
  mkdir submodules && cd submodules
  git submodule add https://github.com/jlblancoc/selfdriving.git 
```
* since its already created, get it with 
```
  git submodule update --init --recursive
```

* Install mrpt requirements
```
  sudo add-apt-repository ppa:joseluisblancoc/mrpt 

  sudo apt-get install libmrpt-dev

  sudo apt-get install -y ros-<distro>-mrpt2 \
                          ros-<distro>-mrpt-msgs \
                          ros-<distro>-marker-msgs
```
* Add mrpt_navigation as a submodule using 
```
  git submodule add https://github.com/mrpt-ros-pkg/mrpt_navigation.git
```
* Get the lidar scan from the Jackal robot using mrpt_local_obstacles node 
using the launch file

* Start publishing the map as a NavMsg using the mrpt_map map_server_node.

* Use the published map for localization node.

# Steps are given below

## Requirements
If you run it on a local machine without containers:
* ROS version at least Kinetic
* CMake version at least 3.0.2
* Python version at least 3.6
* Python packages: defusedxml, rospkg, netifaces, numpy

If you run it in Singularity containers:
* Go version at least 1.13
* Singularity version at least 3.6.3

The requirements above are just suggestions. If you run into any issue, please contact organizers for help (zfxu@utexas.edu).

## Installation
Follow the instructions below to run simulations on your local machines. (You can skip 1-6 if you only use Singularity container)

1. Create a virtual environment (we show examples with python venv, you can use conda instead)
```
apt -y update; apt-get -y install python3-venv
python3 -m venv /<YOUR_HOME_DIR>/nav_challenge
export PATH="/<YOUR_HOME_DIR>/nav_challenge/bin:$PATH"
```

2. Install Python dependencies
```
pip3 install defusedxml rospkg netifaces numpy
```

3. Create ROS workspace
```
mkdir -p /<YOUR_HOME_DIR>/jackal_ws/src
cd /<YOUR_HOME_DIR>/jackal_ws/src
```

4. Clone this repo and required ros packages: (replace `<YOUR_ROS_VERSION>` with your own, e.g. melodic)
```
git clone https://github.com/SRai22/barn-tps-astar-icra2023.git
git clone https://github.com/jackal/jackal.git
git clone https://github.com/jackal/jackal_simulator.git
git clone https://github.com/jackal/jackal_desktop.git 
git clone https://github.com/utexas-bwi/eband_local_planner.git
```

5. Install ROS package dependencies: (replace `<YOUR_ROS_VERSION>` with your own, e.g. melodic)
```
cd ..
source /opt/ros/<YOUR_ROS_VERSION>/setup.bash
rosdep init; rosdep update
rosdep install -y --from-paths . --ignore-src --rosdistro=<YOUR_ROS_VERSION>
```

6. Build the workspace (if `catkin_make` fails, try changing `-std=c++11` to `-std=c++17` in `jackal_helper/CMakeLists.txt` line 3)
```
source devel/setup.bash
catkin_make
```


## Run Simulations
```
source ../../devel/setup.sh
python3 run.py --world_idx 0
```

If you run it in a Singularity container:
```
./singularity_run.sh /path/to/image/file python3 run.py --world_idx 0
```

A successful run should print the episode status (collided/succeeded/timeout) and the time cost in second:
> \>>>>>>>>>>>>>>>>>> Test finished! <<<<<<<<<<<<<<<<<<
>
> Navigation collided with time 27.2930 (s)

> \>>>>>>>>>>>>>>>>>> Test finished! <<<<<<<<<<<<<<<<<<
>
> Navigation succeeded with time 29.4610 (s)


> \>>>>>>>>>>>>>>>>>> Test finished! <<<<<<<<<<<<<<<<<<
>
>Navigation timeout with time 100.0000 (s)

