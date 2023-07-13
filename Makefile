.ONESHELL:
.PHONY: test deps download build clean astyle cmds docker

# GoCV version to use.
GOCV_VERSION?="v0.30.0"

# OpenCV version to use.
OPENCV_VERSION?=4.8.0

# Go version to use when building Docker image
GOVERSION?=1.16.2

# Temporary directory to put files into.
TMP_DIR?=/tmp/

# Build shared or static library
BUILD_SHARED_LIBS?=ON

explain:
	@echo "For quick install with typical defaults of both OpenCV and GoCV, run 'make install'"

# Detect Linux distribution
distro_deps=
ifneq ($(shell which dnf 2>/dev/null),)
	distro_deps=deps_fedora
else
ifneq ($(shell which apt-get 2>/dev/null),)
	distro_deps=deps_debian
else
ifneq ($(shell which yum 2>/dev/null),)
	distro_deps=deps_rh_centos
endif
endif
endif

# Install all necessary dependencies.
deps: $(distro_deps)

# Install all necessary dependencies.
# Download OpenCV source tarballs.
download:
	rm -rf $(TMP_DIR)opencv
	mkdir $(TMP_DIR)opencv
	cd $(TMP_DIR)opencv
	curl -Lo opencv.zip https://github.com/opencv/opencv/archive/$(OPENCV_VERSION).zip
	unzip -q opencv.zip
	curl -Lo opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$(OPENCV_VERSION).zip
	unzip -q opencv_contrib.zip
	rm opencv.zip opencv_contrib.zip
	cd -

# Build OpenCV.
build:
	cd $(TMP_DIR)opencv/opencv-$(OPENCV_VERSION)
	mkdir build
	cd build
	rm -rf *
	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -D OPENCV_EXTRA_MODULES_PATH=$(TMP_DIR)opencv/opencv_contrib-$(OPENCV_VERSION)/modules -DBUILD_CUDA_STUBS=OFF -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_FAT_JAVA_LIB=OFF -DBUILD_IPP_IW=OFF -DBUILD_ITT=OFF -DBUILD_JASPER=OFF -DBUILD_JAVA=OFF -DBUILD_JPEG=ON -DBUILD_LIST= -DBUILD_OPENEXR=OFF -DBUILD_OPENJPEG=ON -DBUILD_PACKAGE=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_PNG=ON -DBUILD_PROTOBUF=OFF -DBUILD_TBB=OFF -DBUILD_TESTS=OFF -DBUILD_TIFF=OFF -DBUILD_USE_SYMLINKS=OFF -DBUILD_WEBP=ON -DWITH_DEBUG_INFO=OFF -DWITH_DYNAMIC_IPP=OFF -DBUILD_opencv_apps=OFF -DBUILD_opencv_aruco=OFF -DBUILD_opencv_barcode=OFF -DBUILD_opencv_bgsegm=OFF -DBUILD_opencv_bioinspired=OFF -DBUILD_opencv_calib3d=OFF -DBUILD_opencv_ccalib=OFF -DBUILD_opencv_core=ON -DBUILD_opencv_datasets=OFF -DBUILD_opencv_dnn=OFF -DBUILD_opencv_dnn_objdetect=OFF -DBUILD_opencv_dnn_superres=OFF -DBUILD_opencv_dpm=OFF -DBUILD_opencv_face=OFF -DBUILD_opencv_features2d=OFF -DBUILD_opencv_flann=OFF -DBUILD_opencv_fuzzy=OFF -DBUILD_opencv_gapi=OFF -DBUILD_opencv_hfs=OFF -DBUILD_opencv_highgui=ON -DBUILD_opencv_img_hash=ON -DBUILD_opencv_imgcodecs=ON -DBUILD_opencv_imgproc=ON -DBUILD_opencv_intensity_transform=OFF -DBUILD_opencv_java_bindings_generator=OFF -DBUILD_opencv_js=OFF -DBUILD_opencv_js_bindings_generator=OFF -DBUILD_opencv_line_descriptor=OFF -DBUILD_opencv_mcc=OFF -DBUILD_opencv_ml=OFF -DBUILD_opencv_objc_bindings_generator=OFF -DBUILD_opencv_objdetect=OFF -DBUILD_opencv_optflow=OFF -DBUILD_opencv_phase_unwrapping=OFF -DBUILD_opencv_photo=OFF -DBUILD_opencv_plot=OFF -DBUILD_opencv_python3=OFF -DBUILD_opencv_python_bindings_generator=OFF -DBUILD_opencv_python_tests=OFF -DBUILD_opencv_quality=OFF -DBUILD_opencv_rapid=OFF -DBUILD_opencv_reg=OFF -DBUILD_opencv_rgbd=OFF -DBUILD_opencv_saliency=OFF -DBUILD_opencv_shape=OFF -DBUILD_opencv_stereo=OFF -DBUILD_opencv_stitching=OFF -DBUILD_opencv_structured_light=OFF -DBUILD_opencv_superres=OFF -DBUILD_opencv_surface_matching=OFF -DBUILD_opencv_text=OFF -DBUILD_opencv_tracking=OFF -DBUILD_opencv_ts=OFF -DBUILD_opencv_video=OFF -DBUILD_opencv_videoio=OFF -DBUILD_opencv_videostab=OFF -DBUILD_opencv_wechat_qrcode=OFF -DBUILD_opencv_world=OFF -DBUILD_opencv_xfeatures2d=OFF -DBUILD_opencv_ximgproc=OFF -DBUILD_opencv_xobjdetect=OFF -DBUILD_opencv_xphoto=OFF -DWITH_1394=OFF -DWITH_ADE=OFF -DWITH_ARITH_DEC=OFF -DWITH_ARITH_ENC=OFF -DWITH_CANN=OFF -DWITH_CLP=OFF -DWITH_CUDA=OFF -DWITH_DIRECTX=OFF -DWITH_DSHOW=OFF -DWITH_EIGEN=OFF -DWITH_FFMPEG=OFF -DWITH_FREETYPE=OFF -DWITH_GDAL=OFF -DWITH_GDCM=OFF -DWITH_GSTREAMER=OFF -DWITH_HALIDE=OFF -DWITH_HPX=OFF -DWITH_IMGCODEC_HDR=OFF -DWITH_IMGCODEC_PFM=OFF -DWITH_IMGCODEC_PXM=OFF -DWITH_IMGCODEC_SUNRASTER=OFF -DWITH_IPP=OFF -DWITH_ITT=OFF -DWITH_JASPER=OFF -DWITH_JPEG=ON -DWITH_LAPACK=OFF -DWITH_LIBREALSENSE=OFF -DWITH_MATLAB=OFF -DWITH_WIN32UI=OFF -DWITH_MFX=OFF -DWITH_MSMF=OFF -DWITH_MSMF_DXVA=OFF -DWITH_OAK=OFF -DWITH_OBSENSOR=OFF -DWITH_ONNX=OFF -DWITH_OPENCL=OFF -DWITH_OPENCLAMDBLAS=OFF -DWITH_OPENCLAMDFFT=OFF -DWITH_OPENCL_D3D11_NV=OFF -DWITH_OPENCL_SVM=OFF -DWITH_OPENEXR=OFF -DWITH_OPENGL=OFF -DWITH_OPENJPEG=ON -DWITH_OPENMP=OFF -DWITH_OPENNI=OFF -DWITH_OPENNI2=OFF -DWITH_OPENVINO=OFF -DWITH_OPENVX=OFF -DWITH_PLAIDML=OFF -DWITH_PNG=ON -DWITH_PROTOBUF=OFF -DWITH_PVAPI=OFF -DWITH_QT=OFF -DWITH_QUIRC=OFF -DWITH_SPNG=OFF -DWITH_TBB=OFF -DWITH_TESSERACT=OFF -DWITH_TIFF=OFF -DWITH_TIMVX=OFF -DWITH_UEYE=OFF -DWITH_VTK=OFF -DWITH_VULKAN=OFF -DWITH_WEBNN=OFF -DWITH_WEBP=ON -DWITH_XIMEA=OFF -DWITH_GTK=OFF -DOPENCV_GENERATE_PKGCONFIG=ON ..
	$(MAKE) -j $(shell nproc --all)
	$(MAKE) preinstall
	cd -

# Build OpenCV staticly linked
build_static:
	cd $(TMP_DIR)opencv/opencv-$(OPENCV_VERSION)
	mkdir build
	cd build
	rm -rf *
	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -DOPENCV_EXTRA_MODULES_PATH=$(TMP_DIR)opencv/opencv_contrib-$(OPENCV_VERSION)/modules -DBUILD_SHARED_LIBS=OFF -DBUILD_CUDA_STUBS=OFF -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_FAT_JAVA_LIB=OFF -DBUILD_IPP_IW=OFF -DBUILD_ITT=OFF -DBUILD_JASPER=OFF -DBUILD_JAVA=OFF -DBUILD_JPEG=ON -DBUILD_LIST= -DBUILD_OPENEXR=OFF -DBUILD_OPENJPEG=ON -DBUILD_PACKAGE=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_PNG=ON -DBUILD_PROTOBUF=OFF -DBUILD_TBB=OFF -DBUILD_TESTS=OFF -DBUILD_TIFF=OFF -DBUILD_USE_SYMLINKS=OFF -DBUILD_WEBP=ON -DWITH_DEBUG_INFO=OFF -DWITH_DYNAMIC_IPP=OFF -DBUILD_opencv_apps=OFF -DBUILD_opencv_aruco=OFF -DBUILD_opencv_barcode=OFF -DBUILD_opencv_bgsegm=OFF -DBUILD_opencv_bioinspired=OFF -DBUILD_opencv_calib3d=OFF -DBUILD_opencv_ccalib=OFF -DBUILD_opencv_core=ON -DBUILD_opencv_datasets=OFF -DBUILD_opencv_dnn=OFF -DBUILD_opencv_dnn_objdetect=OFF -DBUILD_opencv_dnn_superres=OFF -DBUILD_opencv_dpm=OFF -DBUILD_opencv_face=OFF -DBUILD_opencv_features2d=OFF -DBUILD_opencv_flann=OFF -DBUILD_opencv_fuzzy=OFF -DBUILD_opencv_gapi=OFF -DBUILD_opencv_hfs=OFF -DBUILD_opencv_highgui=ON -DBUILD_opencv_img_hash=ON -DBUILD_opencv_imgcodecs=ON -DBUILD_opencv_imgproc=ON -DBUILD_opencv_intensity_transform=OFF -DBUILD_opencv_java_bindings_generator=OFF -DBUILD_opencv_js=OFF -DBUILD_opencv_js_bindings_generator=OFF -DBUILD_opencv_line_descriptor=OFF -DBUILD_opencv_mcc=OFF -DBUILD_opencv_ml=OFF -DBUILD_opencv_objc_bindings_generator=OFF -DBUILD_opencv_objdetect=OFF -DBUILD_opencv_optflow=OFF -DBUILD_opencv_phase_unwrapping=OFF -DBUILD_opencv_photo=OFF -DBUILD_opencv_plot=OFF -DBUILD_opencv_python3=OFF -DBUILD_opencv_python_bindings_generator=OFF -DBUILD_opencv_python_tests=OFF -DBUILD_opencv_quality=OFF -DBUILD_opencv_rapid=OFF -DBUILD_opencv_reg=OFF -DBUILD_opencv_rgbd=OFF -DBUILD_opencv_saliency=OFF -DBUILD_opencv_shape=OFF -DBUILD_opencv_stereo=OFF -DBUILD_opencv_stitching=OFF -DBUILD_opencv_structured_light=OFF -DBUILD_opencv_superres=OFF -DBUILD_opencv_surface_matching=OFF -DBUILD_opencv_text=OFF -DBUILD_opencv_tracking=OFF -DBUILD_opencv_ts=OFF -DBUILD_opencv_video=OFF -DBUILD_opencv_videoio=OFF -DBUILD_opencv_videostab=OFF -DBUILD_opencv_wechat_qrcode=OFF -DBUILD_opencv_world=OFF -DBUILD_opencv_xfeatures2d=OFF -DBUILD_opencv_ximgproc=OFF -DBUILD_opencv_xobjdetect=OFF -DBUILD_opencv_xphoto=OFF -DWITH_1394=OFF -DWITH_ADE=OFF -DWITH_ARITH_DEC=OFF -DWITH_ARITH_ENC=OFF -DWITH_CANN=OFF -DWITH_CLP=OFF -DWITH_CUDA=OFF -DWITH_DIRECTX=OFF -DWITH_DSHOW=OFF -DWITH_EIGEN=OFF -DWITH_FFMPEG=OFF -DWITH_FREETYPE=OFF -DWITH_GDAL=OFF -DWITH_GDCM=OFF -DWITH_GSTREAMER=OFF -DWITH_HALIDE=OFF -DWITH_HPX=OFF -DWITH_IMGCODEC_HDR=OFF -DWITH_IMGCODEC_PFM=OFF -DWITH_IMGCODEC_PXM=OFF -DWITH_IMGCODEC_SUNRASTER=OFF -DWITH_IPP=OFF -DWITH_ITT=OFF -DWITH_JASPER=OFF -DWITH_JPEG=ON -DWITH_LAPACK=OFF -DWITH_LIBREALSENSE=OFF -DWITH_MATLAB=OFF -DWITH_WIN32UI=OFF -DWITH_MFX=OFF -DWITH_MSMF=OFF -DWITH_MSMF_DXVA=OFF -DWITH_OAK=OFF -DWITH_OBSENSOR=OFF -DWITH_ONNX=OFF -DWITH_OPENCL=OFF -DWITH_OPENCLAMDBLAS=OFF -DWITH_OPENCLAMDFFT=OFF -DWITH_OPENCL_D3D11_NV=OFF -DWITH_OPENCL_SVM=OFF -DWITH_OPENEXR=OFF -DWITH_OPENGL=OFF -DWITH_OPENJPEG=ON -DWITH_OPENMP=OFF -DWITH_OPENNI=OFF -DWITH_OPENNI2=OFF -DWITH_OPENVINO=OFF -DWITH_OPENVX=OFF -DWITH_PLAIDML=OFF -DWITH_PNG=ON -DWITH_PROTOBUF=OFF -DWITH_PVAPI=OFF -DWITH_QT=OFF -DWITH_QUIRC=OFF -DWITH_SPNG=OFF -DWITH_TBB=OFF -DWITH_TESSERACT=OFF -DWITH_TIFF=OFF -DWITH_TIMVX=OFF -DWITH_UEYE=OFF -DWITH_VTK=OFF -DWITH_VULKAN=OFF -DWITH_WEBNN=OFF -DWITH_WEBP=ON -DWITH_XIMEA=OFF -DWITH_GTK=OFF -DOPENCV_GENERATE_PKGCONFIG=ON ..
	$(MAKE) -j $(shell nproc --all)
	$(MAKE) preinstall
	cd -

# Cleanup temporary build files.
clean:
	go clean --cache
	rm -rf $(TMP_DIR)opencv

# Cleanup old library files.
sudo_pre_install_clean:
	sudo rm -rf /usr/local/lib/cmake/opencv4/
	sudo rm -rf /usr/local/lib/libopencv*
	sudo rm -rf /usr/local/lib/pkgconfig/opencv*
	sudo rm -rf /usr/local/include/opencv*

# Do everything.
install: deps download sudo_pre_install_clean build sudo_install clean verify

# Do everything.
install_static: deps download sudo_pre_install_clean build_static sudo_install clean verify

# Install system wide.
sudo_install:
	cd $(TMP_DIR)opencv/opencv-$(OPENCV_VERSION)/build
	sudo $(MAKE) install
	sudo ldconfig
	cd -

# Build a minimal Go app to confirm gocv works.
verify:
	go run ./cmd/version/main.go

releaselog:
	git log --pretty=format:"%s" $(GOCV_VERSION)..HEAD