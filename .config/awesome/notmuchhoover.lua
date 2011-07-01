local string = string
local tostring = tostring
local io = io
local table = table
local pairs = pairs
local capi = {
    mouse = mouse,
    screen = screen
}
local json = require("json")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require('beautiful')
module("notmuchhoover")

local popup
local query_format = "<span color='" .. beautiful.fg_urgent .."'><b><u>%s</u>\n</b></span>"
local msg_format = "<span color='" .. beautiful.fg_focus .. "'>%s: </span><span color='" .. beautiful.fg_normal .."'>%s </span></span><span color='" .. beautiful.fg_urgent .."'>(%s)"

function addToWidget(mywidget, querystring, maxcount)
  mywidget:add_signal('mouse::enter', function ()
        local info = read_index(querystring,maxcount)
        popup = naughty.notify({
                title = string.format(query_format,querystring),
                text = info,
                timeout = 0,
                hover_timeout = 0.5,
                screen = capi.mouse.screen
        })
  end)
  mywidget:add_signal('mouse::leave', function () naughty.destroy(popup) end)
end
function read_index(querystring,maxcount)
    local info = ""
    local count = 0

    local f = io.popen("notmuch show --format=json "..querystring)
    local msgs = json.decode(f:read("*all"))
    f:close()

    for i,v in pairs(msgs) do
        if count == maxcount then break else count = count +1 end
        msg = v[1][1]
        date = msg["date_relative"]
        subject = msg["headers"]["Subject"]
        subject = string.gsub(subject, "<(.*)>","\<%1\>")
        from = msg["headers"]["From"]
        from = string.gsub(from, "<(.*)>","")
        tags = table.concat(msg["tags"],', ')

        info = info .. string.format(msg_format,from,subject,tags) .. '\n' 
    end
   return info
end
