// Create Operations
var pushRight = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/3"
});

var pushLeft = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/3"
});

var pushTop = slate.operation("push", {
  "direction" : "top",
  "style" : "bar-resize:screenSizeX/2"
});

var fullscreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

// Bind A Crazy Function to 1+ctrl
slate.bind("1:ctrl", function(win) {
  // here win is a reference to the currently focused window
  if (win.title() === "OMG I WANT TO BE FULLSCREEN") {
    win.doOperation(fullscreen);
    return;
  }
  var appName = win.app().name();
  if (appName === "iTerm") {
    win.doOperation(pushRight);
  } else if (appName === "Google Chrome") {
    win.doOperation(pushLeft);
  } else {
    win.doOperation(pushTop);
  }
});
