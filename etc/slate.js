// Halves

var pushRight = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/2"
});

var pushLeft = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/2"
});

var pushDown = slate.operation("push", {
  "direction" : "down",
  "style" : "bar-resize:screenSizeY/2"
});

var pushUp = slate.operation("push", {
  "direction" : "up",
  "style" : "bar-resize:screenSizeY/2"
});

// Corners

var topLeft = slate.operation("corner", {
  "direction": "top-left",
  "width": "screenSizeX/2",
  "height": "screenSizeY/2"
});

var topRight = slate.operation("corner", {
  "direction": "top-right",
  "width": "screenSizeX/2",
  "height": "screenSizeY/2"
});

var bottomLeft = slate.operation("corner", {
  "direction": "bottom-left",
  "width": "screenSizeX/2",
  "height": "screenSizeY/2"
});

var bottomRight = slate.operation("corner", {
  "direction": "bottom-right",
  "width": "screenSizeX/2",
  "height": "screenSizeY/2"
});

// Fullscreen

var fullScreen = slate.operation("move", {
  "x": "screenOriginX",
  "y": "screenOriginY",
  "width" : "screenSizeX",
  "height": "screenSizeY"
});

// 9/10 screen centered

var centered = slate.operation("move", {
  "x": "screenSizeX*1/20",
  "y": "screenOriginY",
  "width" : "screenSizeX*9/10",
  "height": "screenSizeY"
});

// 3/4 screen left

var threeQuarterLeft = slate.operation("move", {
  "x": "screenOriginX",
  "y": "screenOriginY",
  "width" : "screenSizeX*3/4",
  "height": "screenSizeY"
});

// 1/4 screen right

var oneQuarterRight = slate.operation("move", {
  "x": "screenSizeX*3/4",
  "y": "screenOriginY",
  "width" : "screenSizeX*1/4",
  "height": "screenSizeY"
});

var switchWindow = slate.operationFromString("switch");

// Bindings

slate.bind("left:ctrl;cmd;alt", pushLeft);
slate.bind("right:ctrl;cmd;alt", pushRight);
slate.bind("up:ctrl;cmd;alt", pushUp);
slate.bind("down:ctrl;cmd;alt", pushDown);

slate.bind("m:ctrl;cmd;alt", fullScreen);
slate.bind("c:ctrl;cmd;alt", centered);
slate.bind("h:ctrl;cmd;alt", threeQuarterLeft);
slate.bind("l:ctrl;cmd;alt", oneQuarterRight);

slate.bind("left:ctrl;shift;alt", topLeft);
slate.bind("right:ctrl;shift;alt", bottomRight);
slate.bind("up:ctrl;shift;alt", topRight);
slate.bind("down:ctrl;shift;alt", bottomLeft);

//slate.bind("tab:alt", switchWindow);
//slate.bind("esc:cmd" : S.op("hint"));
//slate.bind("esc:ctrl" : S.op("grid"));
