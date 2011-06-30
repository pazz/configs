---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
---------------------------------------------------

-- {{{ Grab environment
local io = { popen = io.popen }
local tonumber = tonumber
local setmetatable = setmetatable
-- }}}


-- Notmuch: provides mailcount for a requested querystring
module("vicious.contrib.notmuch")


-- {{{ Notmuch widget type
local function worker(format, warg)
    local f = io.popen("notmuch count "..warg)
    count = tonumber(f:read())
    f:close()
    return {count}
end
-- }}}

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
