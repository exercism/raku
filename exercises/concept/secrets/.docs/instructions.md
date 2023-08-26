# Instructions

In this exercise, you've been tasked with writing the software for an encryption device that works by performing transformations on data. You need a way to flexibly create complicated functions by combining simpler functions together.

For each task, return a block that can be invoked from the calling scope.

## 1. Create an adder

Implement `secret-add`.
It should return a function which takes one argument and adds to it the argument passed in to `secret-add`.

## 2. Create a subtractor

Implement `secret-subtract`.
It should return a function which takes one argument and subtracts the secret passed in to `secret-subtract` from that argument.

## 3. Create a multiplier

Implement `secret-multiply`.
It should return a function which takes one argument and multiplies it by the secret passed in to `secret-multiply`.

## 4. Create a divider

Implement `secret-divide`.
It should return a function which takes one argument and divides it by the secret passed in to `secret-divide`.

## 5. Create a function combiner

Implement `secret-combine`.
It should return a function which takes one argument and applies to it the two functions passed in to `secret-combine` in order.
