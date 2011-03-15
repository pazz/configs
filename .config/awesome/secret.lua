module("secret")
imap_cfg = {
    {
        user      = 'user',
        password  = 'passwd',
        host      = '..',
        ssl       = true,
        port = 993,
        mailboxes = { 'Inbox' },
        command   = 'thunderbird',
    },
    {   
        user = 'user2', 
        password ='pass2',
        host= 'imap.googlemail.com', 
        port = 993,
        ssl = true, 
        mailboxes = { 'INBOX'},
    }
}
