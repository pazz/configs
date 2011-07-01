----------------------------------------------------------
-- Licensed under the GNU General Public License v2     --
-- * (c) 2011, Patrick Totzke <patricktotzke@gmail.com> --
----------------------------------------------------------

-- {{{ Grab environment
local io = { popen = io.popen }
local tonumber = tonumber
local setmetatable = setmetatable
local json = require("json")
-- }}}


-- Notmuch: provides count and latest of the messages that match a given querystring
module("vicious.contrib.notmuch")


-- {{{ Notmuch widget type
local function worker(format, warg)
    local f = io.popen("notmuch count "..warg)
    count = tonumber(f:read())
    f:close()

    local f = io.popen("notmuch show --format=json "..warg)
    local msgs = json.decode(f:read("*all"))
    f:close()
    latest = msgs[1][1][1]
    return {count,latest}
end
-- }}}

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
