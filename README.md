Welcome to Building a better jump in the Godot Game Engine!

There are some actions that are common among all games types. 
That once decided on will cause a ripple through out your entire game. 
And effect the way you design all your levels, enemies, bosses.

Take for example the section at the start of metroid dread, 
after the first save point your funnelled through to this drop and after you can’t return. 
They’re not using collisions or a fancy animation to block your return, they’re using the level 
and the limits of the players jump.

How can we acheive the same?

We can accomplish this through the use of some basics physics equations and flip the script so we 
define jump time and distance so calculate the gravity and speed. 
Which is going to make making your game way easier.

Displacement = Initial Velocity * time + Acceleration * Time(squared) divided by 2

We can substitute our variables and use some algerbra to get

Gravity = (2 x Jump Height) / Jump Peak Time.

The Next Equation we can look to work out is velocity and acceleration.

Vf = Vo + at

The above equation solves for the final velocity of an object when it is undergoing a constant acceleration
This one is a little simpler to apply since We’ve worked out our gravity we just need to substitute in the rest of our variables

Jump Velocity = Gravity * Jump Peak Time

And finally we can put all of this together to calculate our speed. 
This can be accomplished using the velocity equation, which relates the player's speed to the distance 
they need to travel and the time it takes to cover that distance. 
incorporating the velocity equation into our design process can help us create more engaging and challenging levels, 
while also improving the overall feel and responsiveness of the game's jumping mechanics.

Velocity = Distance / Over Time

We can substitute our variable as such

Speed = JumpDistance / (Jump Peak Time+Jump Fall Time)
