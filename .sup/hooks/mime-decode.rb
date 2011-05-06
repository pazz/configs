case content_type
when "text/html"
  `/usr/bin/lynx -dump '#{filename}'`
end
