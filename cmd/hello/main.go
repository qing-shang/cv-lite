package main

import (
	"gocv.io/x/gocv"
)

func main() {
	window := cv_lite.NewWindow("Hello")
	img := cv_lite.NewMat()

	for {
		window.IMShow(img)
		window.WaitKey(1)
	}
}
