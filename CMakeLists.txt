cmake_minimum_required(VERSION 3.10.1)

PROJECT(SHOW)

# OpenCV Lib
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

# cuda
find_package(CUDA REQUIRED)
enable_language(CUDA)
include_directories(/usr/local/cuda/include)
link_directories(/usr/local/cuda/lib64)

# tensorrt
include_directories(/usr/include/x86_64-linux-gnu/)
link_directories(/usr/lib/x86_64-linux-gnu/)

# Python
find_package(PythonLibs REQUIRED)
include_directories(${PYTHON_INCLUDE_DIRS})

cuda_add_library(Show SHARED process.cu)
# cuda_add_executable(Show main.cpp)
target_link_libraries(Show ${OpenCV_LIBS})
target_link_libraries(Show nvinfer)
target_link_libraries(Show cudart)
target_link_libraries(Show ${PYTHON_LIBRARIES})