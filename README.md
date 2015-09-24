# objc_gol_sicpers
Graham Lee's GoL redone in modern Objective-C, with possible higher-order messaging implementations.

This project is based on the app example from the [AWESOME](http://www.sicpers.info/2015/05/object-oriented-programming-in-objective-c/) "Object-Oriented Programming in Objective-C" talk by Graham Lee ([video](https://www.youtube.com/watch?v=_BbGxpiYFDg)).

The original project can be found on [BitBucket](https://bitbucket.org/iamleeg/life/src).

I made some stylistic and polymorphic changes, and tried to implement the "higher-order messaging" example (i.e. something like `[[visitation times:n*n] visitNext]`) in a couple of ways:

- in the "higher_order_messaging" branch there's a solution that's rather elegant but requires high dynamism;
- in the "higher_order_messaging_ugly" branch there's a worse, uglier solution, but it's more type safe;

As with the original project, this is free, but it should be seen as an educational effort, rather than a production-ready framework or something like that.

Please learn things yourself, don't outsurce knowledge.
