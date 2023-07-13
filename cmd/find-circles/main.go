// What it does:
//
// This example shows how to find circles in an image using Hough transform.
//
// How to run:
//
// 		go run ./cmd/find-circles/main.go ./images/circles.jpg
//

package main

import (
	"fmt"
	"image"
	"image/color"
	"os"

	"gocv.io/x/gocv"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("How to run:\n\tfind-circles [imgfile]")
		return
	}

	filename := os.Args[1]

	window := cv_lite.NewWindow("detected circles")
	defer window.Close()

	img := cv_lite.IMRead(filename, cv_lite.IMReadGrayScale)
	defer img.Close()

	cv_lite.MedianBlur(img, &img, 5)

	cimg := cv_lite.NewMat()
	defer cimg.Close()

	cv_lite.CvtColor(img, &cimg, cv_lite.ColorGrayToBGR)

	circles := cv_lite.NewMat()
	defer circles.Close()

	cv_lite.HoughCirclesWithParams(
		img,
		&circles,
		cv_lite.HoughGradient,
		1,                     // dp
		float64(img.Rows()/8), // minDist
		75,                    // param1
		20,                    // param2
		10,                    // minRadius
		0,                     // maxRadius
	)

	blue := color.RGBA{0, 0, 255, 0}
	red := color.RGBA{255, 0, 0, 0}

	for i := 0; i < circles.Cols(); i++ {
		v := circles.GetVecfAt(0, i)
		// if circles are found
		if len(v) > 2 {
			x := int(v[0])
			y := int(v[1])
			r := int(v[2])

			cv_lite.Circle(&cimg, image.Pt(x, y), r, blue, 2)
			cv_lite.Circle(&cimg, image.Pt(x, y), 2, red, 3)
		}
	}

	for {
		window.IMShow(cimg)

		if window.WaitKey(10) >= 0 {
			break
		}
	}
}
