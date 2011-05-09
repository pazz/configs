#sent mail
if message.from.email =~ /patricktotzke@gmail.com/i
  message.add_label "sent"
  message.remove_label "inbox"
end

#remove read mail from inbox
if not message.labels.any? { |l| l == "unread" }
  message.remove_label "inbox"
end

#UoE
if (message.from.email =~ /rmayr@/i) or (message.from.email =~ /cps@staffmail/i)
  message.add_label "supervisor" 
end

# lists
if message.recipients.any? { |person| person.email =~ /sup-talk@rubyforge.org/i }
  message.add_label "sup"
  message.add_label "talk"
end
if message.recipients.any? { |person| person.email =~ /sup-devel@rubyforge.org/i }
  message.add_label "sup"
  message.add_label "dev"
end
if message.recipients.any? { |person| person.email =~ /atp-vim-list/i }
  message.add_label "atp"
  message.add_label "dev"
end
# Mark if containing recipient (to/cc)
if message.recipients.any? { |person| person.email =~ /offlineimap-project/i }
  message.add_label "offlineimap"
  message.add_label "dev"
  message.remove_label "inbox"
end


#Add a label for each entry in X-Label field of the raw message (e.g. if you already label mail in mutt or procmail using X-Label): 
if message.raw_header =~ /X-Label: /
  xlabelheader = message.raw_header[/X-Label:.*/]
  xlabelheader.scan(/ [a-z0-9\-_+]+/) { |x| message.add_label x.lstrip }
end
