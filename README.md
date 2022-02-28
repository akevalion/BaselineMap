# BaselineMap

[![CI](https://github.com/akevalion/BaselineMap/actions/workflows/runTests.yml/badge.svg)](https://github.com/akevalion/BaselineMap/actions/workflows/runTests.yml)

This application provides visualization of the baselines dependencies. The main class is MBMapBuilder, this creates an inner model to handle dependencies. Users of this class can create custom versions, and select it as default class in the system browser configuration, just look for `BaselineMap`

### Installation 
Try the next incantation on a playground:

```Smalltalk
Metacello new
    baseline: 'BaselineMap';
    repository: 'github://akevalion/BaselineMap/src';
    load.
```


Inspect an instance of BaselineOF

<img width="1348" alt="image" src="https://user-images.githubusercontent.com/10532890/156014144-d2ed7968-2d22-4b21-9dfd-c0a13f86b510.png">

And the system browser

<img width="855" alt="image" src="https://user-images.githubusercontent.com/10532890/156014263-f9f546af-f538-407e-a946-30f2e80abd2d.png">
