----------------------------------------------------------
-- Licensed under the GNU General Public License v2     --
-- * (c) 2011, Patrick Totzke <patricktotzke@gmail.com> --
----------------------------------------------------------

-- {{{ Grab environment
local io = { popen = io.popen }
local tonumber = tonumber
local setmetatable = setmetatable
local table = table
local json = require("json")
-- }}}

-- {{{ Variable definitions
local mail = {
    ["count"] = 0,
    ["latest"] = {
        ["id"] = "",
        ["from"] = "",
        ["subject"] = "",
        ["timestamp"] = "",
        ["date_relative"] = "",
        ["tags"] = "",
    },
}
-- }}}

-- Notmuch: provides count and latest of the messages that match a given querystring
module("vicious.contrib.notmuch")


-- {{{ Notmuch widget type
local function worker(format, warg)
    local f = io.popen("notmuch count "..warg)
    mail["count"] = tonumber(f:read())
    f:close()

    if mail["count"] > 0 then
        local f = io.popen("notmuch show --format=json "..warg)
        local msgs = json.decode(f:read("*all"))
        f:close()
        latest = msgs[1][1][1]
        mail["latest"]["id"] = latest["id"]
        mail["latest"]["date_relative"] = latest["date_relative"]
        mail["latest"]["timestamp"] = latest["timestamp"]
        mail["latest"]["subject"] = latest["headers"]["Subject"]
        mail["latest"]["from"] = latest["headers"]["From"]
        mail["latest"]["tags"] = table.concat(latest["tags"],',')
    end
    return mail
end
-- }}}

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
