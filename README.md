# PixelationTransition

![alt text](https://i.imgur.com/DqcoVbr.gif)


With the minimal amount of code use Apple's native Core Image "CIPixelate" filter when transitioning between scenes in SpriteKit !

There is no way to use CIPixelate on a Transition function (otherwise it would be named CIPixelateTransition) but it can be applied on the SKScene's Nodes before the Transition request is fulfilled.

Core Image filters can be applied to an SKEffectNode (which is a subclass of SKNode). So by moving all the SKScene nodes in an SKS file to a parent SKEffectNode, the filter will run on all of its children.

Usually CIPixelate would spit out the fully converted sprite (image) in an instant, but placing it in a loop and a DispatchQueue to pause between itterations each outputted version can be seen in succession - like animating images one after the other.

The Nodes are de-pixelated when the scene begins, and then pixelated when the scene ends to give a continious feel.

This code can be used in any project, personal or for financial gain.
