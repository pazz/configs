local string = string
--local print = print
local tostring = tostring
local tonumber = tonumber
local io = { popen = io.popen }
local pairs = pairs
local math = { ceil = math.ceil }
local string = { match = string.match }
local capi = {
    mouse = mouse,
    screen = screen
}
local naughty = require("naughty")
local beautiful = require('beautiful')
local vicious = require("vicious")

module("weatherhoover")

local popup
local account_format = "<span color='" .. beautiful.fg_urgent .."'><b>%s</b></span>"
local dir_format = "<span color='" .. beautiful.fg_normal .."'><b>%s</b></span>"
local oldmail_format = "<span color='" .. beautiful.fg_focus .. "'>%s</span>"

local weather = {
    ["{city}"]    = "N/A",
    ["{wind}"]    = "N/A",
    ["{windmph}"] = "N/A",
    ["{windkmh}"] = "N/A",
    ["{sky}"]     = "N/A",
    ["{weather}"] = "N/A",
    ["{tempf}"]   = "N/A",
    ["{tempc}"]   = "N/A",
    ["{humid}"]   = "N/A",
    ["{press}"]   = "N/A"
}
-- {{{ Weather widget type
local function viciousworker(warg)
    if not warg then return end

    -- Get weather forceast by the station ICAO code, from:
    -- * US National Oceanic and Atmospheric Administration
    local noaa = "http://weather.noaa.gov/pub/data/observations/metar/decoded/"
    local f = io.popen("curl --connect-timeout 1 -fsm 3 "..noaa..warg..".TXT")
    local ws = f:read("*all")
    f:close()

    -- Check if there was a timeout or a problem with the station
    if ws == nil then return weather end

    weather["{city}"]    = -- City and/or area
       string.match(ws, "^(.+)%,.*%([%u]+%)") or weather["{city}"]
    weather["{wind}"]    = -- Wind direction and degrees if available
       string.match(ws, "Wind:[%s][%a]+[%s][%a]+[%s](.+)[%s]at.+$") or weather["{wind}"]
    weather["{windmph}"] = -- Wind speed in MPH if available
       string.match(ws, "Wind:[%s].+[%s]at[%s]([%d]+)[%s]MPH") or weather["{windmph}"]
    weather["{sky}"]     = -- Sky conditions if available
       string.match(ws, "Sky[%s]conditions:[%s](.-)[%c]") or weather["{sky}"]
    weather["{weather}"] = -- Weather conditions if available
       string.match(ws, "Weather:[%s](.-)[%c]") or weather["{weather}"]
    weather["{tempf}"]   = -- Temperature in fahrenheit
       string.match(ws, "Temperature:[%s]([%-]?[%d%.]+).*[%c]") or weather["{tempf}"]
    weather["{humid}"]   = -- Relative humidity in percent
       string.match(ws, "Relative[%s]Humidity:[%s]([%d]+)%%") or weather["{humid}"]
    weather["{press}"]   = -- Pressure in hPa
       string.match(ws, "Pressure[%s].+%((.+)[%s]hPa%)") or weather["{press}"]

    -- Wind speed in km/h if MPH was available
    if weather["{windmph}"] ~= "N/A" then
       weather["{windmph}"] = tonumber(weather["{windmph}"])
       weather["{windkmh}"] = math.ceil(weather["{windmph}"] * 1.6)
    end -- Temperature in °C if °F was available
    if weather["{tempf}"] ~= "N/A" then
       weather["{tempf}"] = tonumber(weather["{tempf}"])
       weather["{tempc}"] = math.ceil((weather["{tempf}"] - 32) * 5/9)
    end -- Capitalize some stats so they don't look so out of place
    if weather["{sky}"] ~= "N/A" then
       weather["{sky}"] = weather["{sky}"]
    end
    if weather["{weather}"] ~= "N/A" then
       weather["{weather}"] = weather["{weather}"]
    end

    return weather
end
function addToWidget(mywidget, location)
  mywidget:add_signal('mouse::enter', function ()
        local w = viciousworker(location)
        popup = naughty.notify({
                --title = string.format(account_format,accountname),
                title = "<span color='" .. beautiful.fg_urgent .."'><b>Weather</b></span>",
                text = "Wind    : " .. w["{windmph}"] .. " mph " .. w["{wind}"] .. 
                       "\nHumidity: " .. w["{humid}"] .. " %\n" ..
                       "Pressure: " .. w["{press}"] .. " hPa\n" ..
                       "weather: ".. w["{weather}"] .. "\n" ..
                       "sky: ".. w["{sky}"] .. "\n", 
                timeout = 0,
                hover_timeout = 0.5,
                screen = capi.mouse.screen
        })
  end)
  mywidget:add_signal('mouse::leave', function () naughty.destroy(popup) end)
end
