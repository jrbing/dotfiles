require '/Applications/Zephyros.app/Contents/Resources/libs/zephyros.rb'

# push to top half of screen
API.bind "K", ["cmd", "alt", "ctrl"] do
  win = API.focused_window
  frame = win.screen.frame_without_dock_or_menu
  frame.h /= 2
  win.frame = frame
end

# alert hello world
API.bind "D", ["Cmd", "Shift"] do
  API.alert 'hello world'
end

wait_on_callbacks
