#sent mail
if message.from.email =~ /patricktotzke@gmail.com/i
  message.add_label "sent"
  message.remove_label "inbox"
end


#UoE
if (message.from.email =~ /rmayr@/i) or (message.from.email =~ /cps@staffmail/i)
  message.add_label "supervisor" 
end
if message.recipients.any? { |person| person.email =~ /hamming-members@inf.ed.ac.uk/i }
  message.add_label "hamming"
  message.add_label "seminars"
  message.remove_label "inbox"
end
if message.recipients.any? { |person| person.email =~ /notmuch@notmuchmail.org/i }
  message.add_label "notmuch"
  if (message.subject =~ /PATCH/i)
    message.remove_label "inbox"
    message.remove_label "unread"
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
if message.recipients.any? { |person| person.email =~ /offlineimap-project/i }
  message.add_label "offlineimap"
  message.add_label "dev"
  message.remove_label "inbox"
end
if message.recipients.any? { |person| person.email =~ /foosoc.ed@gmail.com/i } or message.subject =~ /foosoc/i
  message.add_label "foo"
  message.add_label "soc"
  message.remove_label "inbox"
end


#Add a label for each entry in X-Label field of the raw message (e.g. if you already label mail in mutt or procmail using X-Label): 
if message.raw_header =~ /X-Label: /
  xlabelheader = message.raw_header[/X-Label:.*/]
  xlabelheader.scan(/ [a-z0-9\-_+]+/) { |x| message.add_label x.lstrip }
end
