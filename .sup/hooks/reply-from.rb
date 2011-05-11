
# http://www.mail-archive.com/sup-talk@rubyforge.org/msg01973.html
# Reply with the address they used for me if it's an account of mine
if(b = (message.to + message.cc).find { |p| AccountManager.is_account? p })
    info "using" b "for reply"
    b
else
    case message.from.email
      when /rubyforge.org/i
        info "reply to sup list"
        Person.from_address "Patrick Totzke <patricktotzke@gmail.com>"
      end
end
