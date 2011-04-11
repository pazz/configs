module("secret")
imap_cfg = {
    {
        user      = 's0976898',
        password  = 'epikur98',
        host      = 'imap.sms.ed.ac.uk',
        ssl       = true,
        port = 993,
        mailboxes = { 'Inbox', 'lists/phd-students', 'lists/lfcs' },
        command   = 'urxvt -T mutt -e mutt',
        update_interval    = 60,
    },
    {   
        user = 'patricktotzke@gmail.com', 
        password ='Str@f0rd',
        host= 'imap.googlemail.com', 
        port = 993,
        ssl = true, 
        mailboxes = { 'INBOX'},
        command   = 'urxvt -T mutt -e mutt -F ~/.muttrc.gmail',
        update_interval    = 60,
    }
}
