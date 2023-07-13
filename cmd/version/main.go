// What it does:
//
// 	This program outputs the current OpenCV library version to the console.
//
// How to run:
//
// 		go run ./cmd/version/main.go
//

package main

import (
	"fmt"

	"cv_lite"
)

func main() {
	fmt.Printf("gocv version: %s\n", cv_lite.Version())
	fmt.Printf("opencv lib version: %s\n", cv_lite.OpenCVVersion())
}
