#TrackKit!

TrackKit is a framework for gaming that treats your trackpad like the mouse it isn't.

> Trackpads who seek to be equal with mice lack ambition.

It can: 

* Lock the mouse cursor to the center of an NSView-derived subview **TKDetectorView**, independent of monitor, that tracks and displays touches using NSTouch and NSEvent API.
* Detect **instantaneous/average velocity and direction** in 360 degrees of *individual* to *multiple* NSTouches in 64-bit-ready floating-point.
* Detect intersections with specified trackpad **regions** of various shapes that can be added and modified at run-time
* Show a verbose mode with touches and interpreted **actions** at the end of gesture events.

Currently TrackKit is made to be implemented with SpriteKit. It should work in addition to any type of NSView-derived subclass.

##Roadmap

* Multiplayer support via additional Magic Trackpads.

* Implement as Unity Native Plugin. 

* Figuring out what to do in the wake of NSGestureRecognizer coming to Yosemite.

#Special Thanks
* Nial Giacomelli — [convertToScreenFromLocalPoint](http://nial.me/2012/01/calculating-screen-coordinates-from-view-relative-coordinates-in-cocoa/)
* Oscar Del Ben — [NSScreen+pointConversion](https://github.com/oscardelben/NSScreen-PointConversion)


