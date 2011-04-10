local string = string
--local print = print
local tostring = tostring
local io = io
local lfs = require('lfs')
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

            for line in f:lines() do
               if line:find("^Subject:") then subject = string.match(line, 
"^Subject: (.*)") end
            end
            f:close()
            info = info .. awful.util.escape("\n" .. string.format("%4d %-80.80s", mailcount, subject))
        end
      end
   return info
end

