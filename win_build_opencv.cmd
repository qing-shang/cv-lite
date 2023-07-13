@echo off

if not exist "C:\opencv" mkdir "C:\opencv"

echo Downloading OpenCV sources
echo.
echo For monitoring the download progress please check the C:\opencv directory.
echo.

REM This is why there is no progress bar:
REM https://github.com/PowerShell/PowerShell/issues/2138

echo Downloading: opencv-4.8.0.zip [91MB]
if not exist "c:\opencv\opencv-4.8.0.zip" (powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://github.com/opencv/opencv/archive/4.8.0.zip -OutFile c:\opencv\opencv-4.8.0.zip")
echo Extracting...
if not exist "c:\opencv\opencv-4.8.0"  powershell -command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path c:\opencv\opencv-4.8.0.zip -DestinationPath c:\opencv"
REM del c:\opencv\opencv-4.8.0.zip /q
echo.

echo Downloading: opencv_contrib-4.8.0.zip [58MB]
if not exist "c:\opencv\opencv_contrib-4.8.0.zip" (powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://github.com/opencv/opencv_contrib/archive/4.8.0.zip -OutFile c:\opencv\opencv_contrib-4.8.0.zip")
echo Extracting...
if not exist "c:\opencv\opencv_contrib-4.8.0" powershell -command "$ProgressPreference = 'SilentlyContinue'; Expand-Archive -Path c:\opencv\opencv_contrib-4.8.0.zip -DestinationPath c:\opencv"
REM del c:\opencv\opencv_contrib-4.8.0.zip /q
echo.

echo Done with downloading and extracting sources.
echo.

@echo on
REM C:\msys64\mingw64\bin C:\mingw64\bin
set PATH=%PATH%;D:\UseApp\CMake\bin;C:\msys64\mingw64\bin
if [%1]==[static] (
  set buildPath=C:\opencv\build_static
  set enable_shared=OFF
  set STATIC_CRT=ON
) else (
  set buildPath=C:\opencv\build_share
  set enable_shared=ON
  set STATIC_CRT=OFF
)

if not exist %buildPath% (mkdir %buildPath%)
cd /D %buildPath%
cmake C:\opencv\opencv-4.8.0 -G "MinGW Makefiles" -B%buildPath% -DOPENCV_EXTRA_MODULES_PATH=C:\opencv\opencv_contrib-4.8.0\modules -DBUILD_SHARED_LIBS=%enable_shared% -DBUILD_CUDA_STUBS=OFF -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_FAT_JAVA_LIB=OFF -DBUILD_IPP_IW=OFF -DBUILD_ITT=OFF -DBUILD_JASPER=OFF -DBUILD_JAVA=OFF -DBUILD_JPEG=ON -DBUILD_LIST= -DBUILD_OPENEXR=OFF -DBUILD_OPENJPEG=ON -DBUILD_PACKAGE=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_PNG=ON -DBUILD_PROTOBUF=OFF -DBUILD_TBB=OFF -DBUILD_TESTS=OFF -DBUILD_TIFF=OFF -DBUILD_USE_SYMLINKS=OFF -DBUILD_WEBP=ON -DWITH_DEBUG_INFO=OFF -DWITH_DYNAMIC_IPP=OFF -DBUILD_opencv_apps=OFF -DBUILD_opencv_aruco=OFF -DBUILD_opencv_barcode=OFF -DBUILD_opencv_bgsegm=OFF -DBUILD_opencv_bioinspired=OFF -DBUILD_opencv_calib3d=OFF -DBUILD_opencv_ccalib=OFF -DBUILD_opencv_core=ON -DBUILD_opencv_datasets=OFF -DBUILD_opencv_dnn=OFF -DBUILD_opencv_dnn_objdetect=OFF -DBUILD_opencv_dnn_superres=OFF -DBUILD_opencv_dpm=OFF -DBUILD_opencv_face=OFF -DBUILD_opencv_features2d=OFF -DBUILD_opencv_flann=OFF -DBUILD_opencv_fuzzy=OFF -DBUILD_opencv_gapi=OFF -DBUILD_opencv_hfs=OFF -DBUILD_opencv_highgui=ON -DBUILD_opencv_img_hash=ON -DBUILD_opencv_imgcodecs=ON -DBUILD_opencv_imgproc=ON -DBUILD_opencv_intensity_transform=OFF -DBUILD_opencv_java_bindings_generator=OFF -DBUILD_opencv_js=OFF -DBUILD_opencv_js_bindings_generator=OFF -DBUILD_opencv_line_descriptor=OFF -DBUILD_opencv_mcc=OFF -DBUILD_opencv_ml=OFF -DBUILD_opencv_objc_bindings_generator=OFF -DBUILD_opencv_objdetect=OFF -DBUILD_opencv_optflow=OFF -DBUILD_opencv_phase_unwrapping=OFF -DBUILD_opencv_photo=OFF -DBUILD_opencv_plot=OFF -DBUILD_opencv_python3=OFF -DBUILD_opencv_python_bindings_generator=OFF -DBUILD_opencv_python_tests=OFF -DBUILD_opencv_quality=OFF -DBUILD_opencv_rapid=OFF -DBUILD_opencv_reg=OFF -DBUILD_opencv_rgbd=OFF -DBUILD_opencv_saliency=OFF -DBUILD_opencv_shape=OFF -DBUILD_opencv_stereo=OFF -DBUILD_opencv_stitching=OFF -DBUILD_opencv_structured_light=OFF -DBUILD_opencv_superres=OFF -DBUILD_opencv_surface_matching=OFF -DBUILD_opencv_text=OFF -DBUILD_opencv_tracking=OFF -DBUILD_opencv_ts=OFF -DBUILD_opencv_video=OFF -DBUILD_opencv_videoio=OFF -DBUILD_opencv_videostab=OFF -DBUILD_opencv_wechat_qrcode=OFF -DBUILD_opencv_world=OFF -DBUILD_opencv_xfeatures2d=OFF -DBUILD_opencv_ximgproc=OFF -DBUILD_opencv_xobjdetect=OFF -DBUILD_opencv_xphoto=OFF -DWITH_1394=OFF -DWITH_ADE=OFF -DWITH_ARITH_DEC=OFF -DWITH_ARITH_ENC=OFF -DWITH_CANN=OFF -DWITH_CLP=OFF -DWITH_CUDA=OFF -DWITH_DIRECTX=OFF -DWITH_DSHOW=OFF -DWITH_EIGEN=OFF -DWITH_FFMPEG=OFF -DWITH_FREETYPE=OFF -DWITH_GDAL=OFF -DWITH_GDCM=OFF -DWITH_GSTREAMER=OFF -DWITH_HALIDE=OFF -DWITH_HPX=OFF -DWITH_IMGCODEC_HDR=OFF -DWITH_IMGCODEC_PFM=OFF -DWITH_IMGCODEC_PXM=OFF -DWITH_IMGCODEC_SUNRASTER=OFF -DWITH_IPP=OFF -DWITH_ITT=OFF -DWITH_JASPER=OFF -DWITH_JPEG=ON -DWITH_LAPACK=OFF -DWITH_LIBREALSENSE=OFF -DWITH_MATLAB=OFF -DWITH_WIN32UI=OFF -DWITH_MFX=OFF -DWITH_MSMF=OFF -DWITH_MSMF_DXVA=OFF -DWITH_OAK=OFF -DWITH_OBSENSOR=OFF -DWITH_ONNX=OFF -DWITH_OPENCL=OFF -DWITH_OPENCLAMDBLAS=OFF -DWITH_OPENCLAMDFFT=OFF -DWITH_OPENCL_D3D11_NV=OFF -DWITH_OPENCL_SVM=OFF -DWITH_OPENEXR=OFF -DWITH_OPENGL=OFF -DWITH_OPENJPEG=ON -DWITH_OPENMP=OFF -DWITH_OPENNI=OFF -DWITH_OPENNI2=OFF -DWITH_OPENVINO=OFF -DWITH_OPENVX=OFF -DWITH_PLAIDML=OFF -DWITH_PNG=ON -DWITH_PROTOBUF=OFF -DWITH_PVAPI=OFF -DWITH_QT=OFF -DWITH_QUIRC=OFF -DWITH_SPNG=OFF -DWITH_TBB=OFF -DWITH_TESSERACT=OFF -DWITH_TIFF=OFF -DWITH_TIMVX=OFF -DWITH_UEYE=OFF -DWITH_VTK=OFF -DWITH_VULKAN=OFF -DWITH_WEBNN=OFF -DWITH_WEBP=ON -DWITH_XIMEA=OFF -DOPENCV_ALLOCATOR_STATS_COUNTER_TYPE=int64_t -Wno-dev
mingw32-make -j%NUMBER_OF_PROCESSORS%
mingw32-make install
::REM rmdir c:\opencv\opencv-4.8.0 /s /q
::REM rmdir c:\opencv\opencv_contrib-4.8.0 /s /q
::REM chdir /D %GOPATH%\src\gocv.io\x\gocv
