package main

import (
	"fmt"
	"math"
)
// This app is a calculator we will use go to perform arithmatic 
func main() {
	var number, numberTwo float64
	var operToPerf string 

	fmt.Println("This app will perform calculations based on your input.")
	fmt.Print("input a number: ")
	fmt.Scan(&number)
	// validate inputs ensure only non symbolcharacters are accepted
	fmt.Println("Your first number is:", number)
	fmt.Print("Give me another number: ")
	fmt.Scan(&numberTwo)
	fmt.Println("Your second number is:", numberTwo)
	fmt.Print("Give me the operation you want to perform?")
	fmt.Scan(&operToPerf)
	// must be a string
	fmt.Println("We will be performing", number,operToPerf, numberTwo)
	switch operToPerf {
	case "+":
		fmt.Println(number, "+", numberTwo, "=", number + numberTwo )
	case "-":
		fmt.Println(number, "-", numberTwo, "=", number - numberTwo )
	case "*":
		fmt.Println(number, "*", numberTwo, "=", number * numberTwo )
	case "/":
		if ( number == 0 ) || ( numberTwo == 0 ) {
		fmt.Println("Division by 0 is not allowed")
	} else {
		fmt.Println(number,"/", numberTwo, "=", number / numberTwo)
	}
		// I need to add an ability to address division by 0
	case "^":
		total := math.Pow(number, numberTwo)
		fmt.Println(number,"^", numberTwo, "=", total) 
	case "%":
		fmt.Println(number,"%", numberTwo, "=", int(number) % int(numberTwo))
	default:
		fmt.Println("This is not an operation we can perform...yet. Please only use +,-,*,/,^,%")
	}
}


		
