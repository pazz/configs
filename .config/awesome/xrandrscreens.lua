module("xrandrscreens")

function xrandr_screens ()
    local screens = {}
    local counter = 1
    local handle = io.popen("xrandr -q")
    for display in handle:read("*all"):gmatch("([%a%d-]+) connected") do
        screens[display] = counter
        counter = counter + 1
    end
    handle:close()
    return screens
end
