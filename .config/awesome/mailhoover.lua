local string = string
--local print = print
local tostring = tostring
local io = io
local lfs = require('lfs') -- this is liblua5.1-filesystem-dev in ubuntu
local capi = {
    mouse = mouse,
    screen = screen
}
local awful = require("awful")
local naughty = require("naughty")
module("mailhoover")

local n

function addToWidget(mywidget, mdir, accountname)
  mywidget:add_signal('mouse::enter', function ()
        local info = read_maildir(mdir)
        n = naughty.notify({
                title = accountname,
                text = string.format('<span font_desc="%s">%s</span>', "monospace", info),
                timeout = 0,
                hover_timeout = 0.5,
                screen = capi.mouse.screen
        })
  end)
  mywidget:add_signal('mouse::leave', function () naughty.destroy(n) end)
end
function read_maildir (mdir)
      local mailcount = 0
      local info = ""

      for msgfile in lfs.dir(mdir .. "new") do
         if lfs.attributes(mdir .. "new/" .. msgfile, "mode") == 
"file" then
            mailcount = mailcount + 1
            f = io.open( mdir .. "new/" .. msgfile)

            subject = ""
            from = ""
            for line in f:lines() do
               if line:find("^Subject:") then subject = string.match(line, "^Subject: (.*)") end
               if line:find("^From:") then 
                   from = string.match(line, "^From: (.*)") 
                   from = string.gsub(from, "<.*>","")
               end
            end
            f:close()
            info = info .. awful.util.escape("\n" .. string.format("%-50s %-80.80s", from, subject))
        end
      end
   return info
end

