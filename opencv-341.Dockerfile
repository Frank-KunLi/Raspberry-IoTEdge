FROM resin/rpi-raspbian:stretch

#Enforces cross-compilation through Quemu
RUN [ "cross-build-start" ]

# Install CV2 dependencies and build cv2
RUN apt-get update && apt-get upgrade \
               && apt-get install -y \                              
                              build-essential cmake pkg-config \
                              libjpeg-dev libtiff5-dev libjasper-dev libpng-dev \
                              libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
                              libxvidcore-dev libx264-dev \
                              libgdk-pixbuf2.0-dev \
                              libfontconfig1-dev \
                              libcairo2-dev \
                              libpango1.0-dev \
                              libgdk-pixbuf2.0-dev \
                              libpango1.0-dev \
                              libxft-dev \
                              libfreetype6-dev \
                              libpng-dev \
                              libgtk2.0-dev \                                                                                                                                   
                              libgtk-3-dev \
                              libatlas-base-dev gfortran \
                              python3-dev \
                              python3-pip \
                              wget \  
                              unzip \ 
               && rm -rf /var/lib/apt/lists/* \
               && apt-get -y autoremove \                           
               && wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.1.zip \
               && unzip opencv.zip \
               && rm -rf opencv.zip \
               && wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.1.zip \
               && unzip opencv_contrib.zip \
               && rm -rf opencv_contrib.zip \
               && pip3 install --upgrade pip \
               && pip install numpy \
               && ls \
               && cd opencv-3.4.1/ \
               && mkdir build \
               && cd build \
               && cmake -D CMAKE_BUILD_TYPE=RELEASE \
                    -D CMAKE_INSTALL_PREFIX=/usr/local \
                    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.4.1/modules \
                    -D BUILD_EXAMPLES=ON \
                	-D BUILD_WITH_DEBUG_INFO=OFF \
	                -D BUILD_DOCS=OFF \
	                -D BUILD_EXAMPLES=OFF \
                    -D BUILD_TESTS=OFF \
                    -D BUILD_opencv_ts=OFF \
                    -D BUILD_PERF_TESTS=OFF \
                    -D INSTALL_C_EXAMPLES=OFF \
                    -D INSTALL_PYTHON_EXAMPLES=ON \
                    -D ENABLE_NEON=ON \
                    -D WITH_LIBV4L=ON \
                    -D WITH_OPENGL=ON \
                    .. \
               && make -j4 \
               && make install \
               && ldconfig \
               && rm -rf ../../opencv-3.4.1 ../../opencv_contrib-3.4.1

RUN [ "cross-build-end" ]  
