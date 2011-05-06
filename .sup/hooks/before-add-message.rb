#rm
if message.from.email =~ /rmayr@/i
  message.add_label "sup" 
  message.add_label "richard" 
end
#cps
if message.from.email =~ /cps@staffmail/i
  message.add_label "sup" 
  message.add_label "colin" 
end

#Add a label for each entry in X-Label field of the raw message (e.g. if you already label mail in mutt or procmail using X-Label): 
if message.raw_header =~ /X-Label: /
  xlabelheader = message.raw_header[/X-Label:.*/]
  xlabelheader.scan(/ [a-z0-9\-_+]+/) { |x| message.add_label x.lstrip }
end
