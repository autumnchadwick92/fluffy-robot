FROM python:3

WORKDIR /robotapp/

#setup rclpy
RUN sudo apt install \
  python3-sphinx \
  python3-sphinx-autodoc-typehints \
  python3-sphinx-rtd-theme


#Source ROS Build
RUN . /opt/ros/rolling/setup.bash

#Get the build info
RUN mkdir -p rclpy_ws/src
RUN cd rclpy_ws/src
RUN git clone https://github.com/ros2/rclpy.git
RUN cd ..
RUN colcon build --symlink-install

#Source workspace and build docs:
RUN source install/setup.bash
RUN cd src/rclpy/rclpy/docs
RUN make html

#Setup engine requirments
COPY requirements.txt .
RUN pip install -r requirements.txt

#Grab project code
RUN git clone https://github.com/autumnchadwick92/fluffy-robot.git

ENV PYTHONPATH=/robotapp

WORKDIR /robotapp/app
RUN 