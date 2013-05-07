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

// Bindings 

slate.bind("left:ctrl;cmd;alt", pushLeft);
slate.bind("right:ctrl;cmd;alt", pushRight);
slate.bind("up:ctrl;cmd;alt", pushUp);
slate.bind("down:ctrl;cmd;alt", pushDown);

slate.bind("m:ctrl;cmd;alt", fullScreen);

slate.bind("left:ctrl;shift;alt", topLeft);
slate.bind("right:ctrl;shift;alt", bottomRight);
slate.bind("up:ctrl;shift;alt", topRight);
slate.bind("down:ctrl;shift;alt", bottomLeft);
