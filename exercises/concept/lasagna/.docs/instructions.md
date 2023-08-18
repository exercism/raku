# Instructions

You're going to write some code to help you cook a lasagna from your favorite cookbook.

You have five tasks, all related to cooking your recipe.

## 1. Define the expected oven time in minutes

Set the `$EXPECTED-MINUTES-IN-OVEN` constant with how many minutes the lasagna should be in the oven. According to the cooking book, the expected oven time in minutes is 40:

```raku
$EXPECTED-MINUTES-IN-OVEN
# => 40
```

## 2. Calculate the remaining oven time in minutes

Modify the `remaining-minutes-in-oven` subroutine, which takes the actual minutes the lasagna has been in the oven as an argument, to return how many minutes the lasagna still has to remain in the oven, based on the expected oven time in minutes from the previous task.

```raku
remaining-minutes-in-oven(30)
# => 10
```

## 3. Calculate the preparation time in minutes

Modify the `preparation-time-in-minutes` subroutine, which takes the number of layers you added to the lasagna as an argument, to return how many minutes you spent preparing the lasagna, assuming each layer takes you 2 minutes to prepare.

```raku
preparation-time-in-minutes(2)
# => 4
```

## 4. Calculate the total working time in minutes

Modify the `total-time-in-minutes` subroutine that takes two arguments: the first argument is the number of layers you added to the lasagna, and the second argument is the number of minutes the lasagna has been in the oven.
The subroutine should return how many minutes in total you've worked on cooking the lasagna, which is the sum of the preparation time in minutes, and the time in minutes the lasagna has spent in the oven at the moment.

```raku
total-time-in-minutes(3, 20)
# => 26
```

## 5. Create a notification that the lasagna is ready

Modify the `oven-alarm` subroutine, which does not take any arguments, to return a message indicating that the lasagna is ready to eat.

```raku
oven-alarm()
# => 'Ding!'
```
