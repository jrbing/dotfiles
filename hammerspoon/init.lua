
---------------
--  General  --
---------------

-- Global log level. Per-spoon log level can be configured in each block below
hs.logger.defaultLogLevel="info"

-- Some useful global variables for key binding specifications in
-- Spoon configurations
hyper = {"cmd","alt","ctrl"}
shift_hyper = {"cmd","alt","ctrl","shift"}

--------------
--  Spoons  --
--------------

----------------------------------------------------------------------
-- Set up SpoonInstall - this is the only spoon that needs to be
-- manually installed
-- https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip

hs.loadSpoon("SpoonInstall")

-- I prefer sync notifications, makes them easier to read
spoon.SpoonInstall.use_syncinstall = true

-- This is just a shortcut to make the declarations below look more readable,
-- i.e. `Install:andUse()` instead of `spoon.SpoonInstall:andUse()`
Install=spoon.SpoonInstall

----------------------------------------------------------------------

-- http://www.hammerspoon.org/Spoons/MountedVolumes.html
Install:andUse("MountedVolumes", {
    hotkeys = {
      toggle = { shift_hyper, "1" }
    }
  }
)

----------------------------------------------------------------------

-- Simple window movement and resizing, focusing on half- and third-of-screen sizes
-- http://www.hammerspoon.org/Spoons/WindowHalfsAndThirds.html
-- Variables - Configurable values
--   * clear_cache_after_seconds
--   * defaultHotkeys
--   * logger
--   * use_frame_correctness
-- Methods - API calls which can only be made on an object returned by a constructor
--   * bindHotkeys
--   * center
--   * larger
--   * leftHalf
--   * smaller
--   * toggleMaximized
--   * undo
Install:andUse("WindowHalfsAndThirds",
  {
    config = {
      use_frame_correctness = true
    },
    hotkeys = 'default',
    disable = true
  }
)

--{
    --left_half   = { {"ctrl",        "cmd"}, "Left" },
    --right_half  = { {"ctrl",        "cmd"}, "Right" },
    --top_half    = { {"ctrl",        "cmd"}, "Up" },
    --bottom_half = { {"ctrl",        "cmd"}, "Down" },
    --third_left  = { {"ctrl", "alt"       }, "Left" },
    --third_right = { {"ctrl", "alt"       }, "Right" },
    --third_up    = { {"ctrl", "alt"       }, "Up" },
    --third_down  = { {"ctrl", "alt"       }, "Down" },
    --top_left    = { {"ctrl",        "cmd"}, "1" },
    --top_right   = { {"ctrl",        "cmd"}, "2" },
    --bottom_left = { {"ctrl",        "cmd"}, "3" },
    --bottom_right= { {"ctrl",        "cmd"}, "4" },
    --max_toggle  = { {"ctrl", "alt", "cmd"}, "f" },
    --max         = { {"ctrl", "alt", "cmd"}, "Up" },
    --undo        = { {        "alt", "cmd"}, "z" },
    --center      = { {        "alt", "cmd"}, "c" },
    --larger      = { {        "alt", "cmd", "shift"}, "Right" },
    --smaller     = { {        "alt", "cmd", "shift"}, "Left" },
 --}

----------------------------------------------------------------------

-- Move windows to other screens
-- http://www.hammerspoon.org/Spoons/WindowScreenLeftAndRight.html
Install:andUse("WindowScreenLeftAndRight",
  {
    logger = "debug",
    hotkeys = {
      screen_left = { {"ctrl", "alt", "cmd"}, "Left" },
      screen_right= { {"ctrl", "alt", "cmd"}, "Right" },
    },
    disable = true
  }
)

----------------------------------------------------------------------

-- Show a fading-and-zooming image in the center of the screen
-- http://www.hammerspoon.org/Spoons/FadeLogo.html
Install:andUse("FadeLogo",
  {
    config = {
      run_time = 0.5,
    },
    start = true,
    disable = true
  }
)

----------------------------------------------------------------------

-- ReloadConfiguration
-- Adds a hotkey to reload the hammerspoon configuration, and a
-- pathwatcher to automatically reload on changes.
-- http://www.hammerspoon.org/Spoons/ReloadConfiguration.html
Install:andUse("ReloadConfiguration",
  {
    config = {
      watch_paths = {
        os.getenv("HOME") .. "/.dotfiles/hammerspoon/"
      }
    },
    start = true
  }
)

-----------------
--  Functions  --
-----------------

-- Defines for window maximize toggler
--local frameCache = {}

---- Toggle a window between its normal size, and being maximized
--function maximize_window()
--local win = hs.window.focusedWindow()
--if frameCache[win:id()] then
--win:setFrame(frameCache[win:id()])
--win:ensureIsInScreenBounds(0)
--frameCache[win:id()] = nil
--else
--frameCache[win:id()] = win:frame()
--win:maximize()
--end
--end

--function center_window()
--local win = hs.window.focusedWindow()
--local f = win:frame()
--local max = win:screen():frame()
--f.x = (max.w - max.x - f.w) / 2
--f.y = (max.h - max.y - f.h) / 2
--win:setFrame(f)
--end

---------------
--  Hotkeys  --
---------------

-- Move Outlook to left
-- Center window
-- Maximize window
-- Restore to previous size

--hs.hotkey.bind(hyper, 'F', maximize_window)
--hs.hotkey.bind(hyper, 'C', center_window)
--hs.hotkey.bind(mash, 'Left', function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end)
--hs.hotkey.bind(mash, 'Right', function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end)
--hs.hotkey.bind(mash, 'Up', function() move_window(hs.window.focusedWindow(), hs.geometry.rect(0, 0, 1, 0.5)) end)
--hs.hotkey.bind(mash, 'Down', function() move_window(hs.window.focusedWindow(), hs.geometry.rect(0, 0.5, 1, 0.5)) end)
