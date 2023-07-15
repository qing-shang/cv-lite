//go:build !customenv && !static
// +build !customenv,!static

package cv_lite

// Changes here should be mirrored in contrib/cgo_static.go and cuda/cgo_static.go.

/*
#cgo !windows pkg-config: opencv4
#cgo CXXFLAGS:   --std=c++14
#cgo windows  CPPFLAGS:   -IC:/opencv/build_share/install/include
#cgo windows  LDFLAGS:    -LC:/opencv/build_share/install/x64/mingw/lib -lopencv_core480 -lopencv_imgproc480 -lopencv_highgui480 -lopencv_imgcodecs480 -lopencv_img_hash480
*/
import "C"
