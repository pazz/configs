-------------------------------
--    "Sky" awesome theme    --
--  By Andrei "Garoth" Thorp --
-------------------------------
-- If you want SVGs and extras, get them from garoth.com/awesome/sky-theme

-- BASICS
theme = {}
theme.confdir       = awful.util.getdir("config") .. "/themes/pazz"
theme.font          = "sans 8"

theme.bg_focus      = "#727272"--"#e2eeea"
theme.bg_normal     = "#000000"
--theme.bg_normal     = "#95AFC0"
theme.bg_urgent     = "#fce94f"
theme.bg_minimize   = "#0067ce"

--theme.fg_normal     = "#2e3436"
theme.fg_normal     = "#BBBBBB"
theme.fg_focus      = "#FFFFFF"--"#7E7E7E"
theme.fg_urgent     = "#fce94f"
theme.fg_minimize   = "#2e3436"

theme.border_width  = "3"
--theme.border_normal = "#dae3e0"
theme.border_normal = "#2e3436"
theme.border_focus  = "#95AFC0"
theme.border_marked = "#fce94f"

-- You can use your own layout icons like this:
theme.layout_fairh = theme.confdir .. "/icons/layouts/fairh.png"
theme.layout_fairv = theme.confdir .. "/icons/layouts/fairv.png"
theme.layout_floating  = theme.confdir .. "/icons/layouts/floating.png"
theme.layout_magnifier = theme.confdir .. "/icons/layouts/magnifier.png"
theme.layout_max = theme.confdir .. "/icons/layouts/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/layouts/fullscreen.png"
theme.layout_tilebottom = theme.confdir .. "/icons/layouts/tilebottom.png"
theme.layout_tileleft   = theme.confdir .. "/icons/layouts/tileleft.png"
theme.layout_tile = theme.confdir .. "/icons/layouts/tile.png"
theme.layout_tiletop = theme.confdir .. "/icons/layouts/tiletop.png"
theme.layout_spiral  = theme.confdir .. "/icons/layouts/spiral.png"
theme.layout_dwindle = theme.confdir .. "/icons/layouts/dwindle.png"
-- IMAGES
--theme.tag_sys	=  theme.confdir .. "/icons/sys.png"
theme.tag_sys	=  theme.confdir .. "/icons/picol/settings_16-white.png"
theme.tag_edit	=  theme.confdir .. "/icons/picol/edit_16-white.png"
--theme.tag_web	=  theme.confdir .. "/icons/web.png"
theme.tag_web	=  theme.confdir .. "/icons/picol/globe_16-white.png"
theme.tag_mail	=  theme.confdir .. "/icons/picol/mail_16-white.png"
--theme.tag_mail	=  theme.confdir .. "/icons/mail.png"
theme.tag_snd	=  theme.confdir .. "/icons/snd.png"
--theme.tag_cal	=  theme.confdir .. "/icons/cal.png"
theme.tag_cal	=  theme.confdir .. "/icons/picol/calendar_16-white.png"
--theme.tag_bib	=  theme.confdir .. "/icons/bib.png"
theme.tag_bib	=  theme.confdir .. "/icons/picol/bookmark_16-white.png"
--theme.tag_im	=  theme.confdir .. "/icons/im.png"
--theme.tag_media	=  theme.confdir .. "/icons/media.png"
theme.tag_audio	=  theme.confdir .. "/icons/audio.png"
theme.tag_video	=  theme.confdir .. "/icons/video.png"
theme.tag_im	=  theme.confdir .. "/icons/picol/social_network_16-white.png"

-- widget icons
theme.widget_cpu_hi     = theme.confdir .. "/icons/cpu_hi.png"
theme.widget_cpu_mid    = theme.confdir .. "/icons/cpu_mid.png"
theme.widget_cpu_lo     = theme.confdir .. "/icons/cpu_lo.png"
theme.widget_wifi_hi    = theme.confdir .. "/icons/wifi_hi.png"
theme.widget_wifi_mid   = theme.confdir .. "/icons/wifi_mid.png"
theme.widget_wifi_lo    = theme.confdir .. "/icons/wifi_lo.png"
theme.widget_wifi_off   = theme.confdir .. "/icons/wifi_off.png"

theme.widget_bat_1     = theme.confdir .. "/icons/picol/battery_1_16-white.png"
theme.widget_bat_2     = theme.confdir .. "/icons/picol/battery_2_16-white.png"
theme.widget_bat_3     = theme.confdir .. "/icons/picol/battery_3_16-white.png"
theme.widget_bat_4     = theme.confdir .. "/icons/picol/battery_4_16-white.png"
theme.widget_bat_full     = theme.confdir .. "/icons/picol/battery_full_16-white.png"
theme.widget_bat_plug     = theme.confdir .. "/icons/picol/battery_plugged_16-white.png"
theme.widget_bat_empty    = theme.confdir .. "/icons/picol/battery_empty_16-white.png"

theme.widget_speaker_1     = theme.confdir .. "/icons/picol/speaker_silent_16-white.png"
theme.widget_speaker_2     = theme.confdir .. "/icons/picol/speaker_louder_16-white.png"
theme.widget_speaker_mute  = theme.confdir .. "/icons/picol/speaker_off_16-white.png"
theme.widget_play       = theme.confdir .. "/icons/picol/controls_play_16-white.png"
theme.widget_pause      = theme.confdir .. "/icons/picol/controls_pause_16-white.png"
theme.widget_stop       = theme.confdir .. "/icons/picol/controls_stop_16-white.png"

theme.awesome_icon           = "/usr/share/awesome/themes/sky/awesome-icon.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/sky/layouts/floating.png"

-- from default for now...
theme.menu_submenu_icon     = "/usr/share/awesome/themes/default/submenu.png"
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- MISC
--theme.wallpaper_cmd         = { "awsetbg /home/pazz/Pictures/wallpapers/flora-on-sand-1927.jpg" }
theme.wallpaper_cmd         = { "awsetbg /home/pazz/.config/awesome/themes/pazz/nb.jpg" }
--theme.wallpaper_cmd         = { "awsetbg /home/pazz/.config/awesome/themes/pazz/imm007_8A.jpg" }
--theme.wallpaper_cmd         = { "awsetbg -f -u feh /home/pazz/.config/awesome/themes/pazz/DSC_4729.JPG" }
--theme.wallpaper_cmd         = { "awsetbg -f -u feh /home/pazz/.config/awesome/themes/pazz/imm011_14A.jpg" }
theme.taglist_squares       = "false"
theme.titlebar_close_button = "true"
theme.menu_height           = "20"
theme.menu_width            = "150"
theme.menu_border_width  = "0"

theme.delightful_imap_mail_read   = theme.confdir .. "/icons/tp.gif"
theme.delightful_imap_mail_unread  = theme.confdir .. "/icons/picol/mail_16-white.png"
theme.delightful_error = theme.confdir .. "/icons/picol/mail_cancel_16-white.png"

theme.widget_mail = theme.confdir .. "/icons/picol/mail_16-white.png"
theme.widget_nomail = nil


-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

return theme
