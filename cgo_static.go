//go:build !customenv && static
// +build !customenv,static

package cv_lite

// Changes here should be mirrored in contrib/cgo.go and cuda/cgo.go.

/*
#cgo CXXFLAGS:   --std=c++14
#cgo !windows CPPFLAGS: -I/usr/local/include -I/usr/local/include/opencv4
#cgo !windows LDFLAGS: -L/usr/local/lib -L/usr/local/lib/opencv4/3rdparty -lopencv_highgui -lopencv_freetype -lopencv_img_hash  -lopencv_imgcodecs -lopencv_imgproc -lopencv_core -llibopenjp2 -llibjpeg-turbo -llibwebp -llibpng -lade -lz -ljpeg -ldl -lm -lpthread -lrt -lquadmath
#cgo windows  CPPFLAGS:   -IC:/opencv/build_static/install/include
#cgo windows  LDFLAGS:    -LC:/opencv/build_static/install/x64/mingw/staticlib -lopencv_highgui480 -lopencv_imgcodecs480 -lopencv_img_hash480 -lopencv_imgproc480 -lopencv_core480 -llibpng -llibopenjp2 -llibwebp -llibjpeg-turbo -lzlib
*/
import "C"

//LDFLAGS： -lkernel32 -lgdi32 -lcomdlg32 -luser32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32
