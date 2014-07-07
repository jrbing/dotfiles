#!/usr/bin/env lua
-- appfinder.lua v2014.07.07
-- cmsj@tenshu.net

ext.appfinder = {}

local function find_application_from_windows(title, fn)
    local w = fnutils.find(window.allwindows(), fn)
    if w then
        return w:application()
    else
        return nil
    end
end

-- Finds applications by their name
--  Parameters:
--      name: Application name (e.g. "Safari")
--  Returns:
--      application object or nil
function ext.appfinder.app_from_name(name)
    return fnutils.find(application.runningapplications(), function(app) return app:title() == name end)
end

-- Finds applications by their window title
--  Parameters:
--      title: Window title (e.g. "Activity Monitor (All Processes)")
--  Returns:
--      application object or nil
function ext.appfinder.app_from_window_title(title)
    return find_application_from_windows(title, function(win) return win:title() == title end)
end

-- Finds applications by pattern in their window title
--  Parameters:
--      pattern: Lua pattern (e.g. "Inbox %(%d+ messages.*")
--  Returns:
--      application object or nil
--  Notes:
--      For more about Lua patterns, see:
--       http://lua-users.org/wiki/PatternsTutorial
--       http://www.lua.org/manual/5.2/manual.html#6.4.1
function ext.appfinder.app_from_window_title_pattern(pattern)
    return find_application_from_windows(pattern, function(win) return string.match(win:title(), pattern) end)
end
