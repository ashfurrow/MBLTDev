MBLTDev
=======

Demo of using ReactiveCocoa with Swift at [MBLTDev 2014](http://mbltdev.ru). Slides are available [online](https://speakerdeck.com/ashfurrow/functional-reactive-programming-in-swift).

Instructions
----------------

You'll need to *clone* this repo, *not* download it's zip file. 

```sh
git clone https://github.com/AshFurrow/MBLTDev.git
cd MBLTDev
git submodule update --init
./submodules/ReactiveCocoa/script/bootstrap
```

And open the main Xcode workspace. 

Explanation
----------------

So basically this is a bare-bones setup for what an app using Swift with ReactiveCocoa would look like. Create a workspace with your app and add ReactiveCocoa and LlamaKit. You also have to have your app's target build against ReactiveCocoa and LlamaKit in order to work (at the moment). 
