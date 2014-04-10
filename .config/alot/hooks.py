import re
import urllib2

def whereisit(ui):
    msg = ui.current_buffer.get_selected_message()
    ui.notify('msg file is: %s' % msg.get_filename())

def pa(ui):
    from alot.settings import settings
    ab=settings.get_addressbooks()[0]
    ui.notify("%s" % ab.get_contacts())

def github(ui):
    msg = ui.current_buffer.get_selected_message()
    msgtext = str(msg.get_email())
    r = r'img src=\'(https://github.com/notifications/beacon/.*.gif)\''
    beacons = re.findall(r, msgtext)
    if beacons:
        urllib2.urlopen(beacons[0])
        ui.notify('removed from github notifications:\n %s' % beacons[0])


def unsubscribe():
    """
    Unsubscribe from a mailing list.

    This hook reads the 'List-Unsubscribe' header of a mail in thread mode,
    constructs a unsubsribe-mail according to any mailto-url it finds
    and opens the new mail in an envelope buffer.
    """
    from alot.helper import mailto_to_envelope
    from alot.buffers import EnvelopeBuffer
    msg = ui.current_buffer.get_selected_message()
    e = msg.get_email()
    uheader = e['List-Unsubscribe']
    dtheader = e.get('Delivered-To', None)

    if uheader is not None:
        M = re.search(r'<(mailto:\S*)>', uheader)
        if M is not None:
            env = mailto_to_envelope(M.group(1))
            if dtheader is not None:
                env['From'] = [dtheader]
            ui.buffer_open(EnvelopeBuffer(ui, env))
    else:
        ui.notify('focussed mail contains no \'List-Unsubscribe\' header',
                  'error')

def translate(ui, targetlang='en'):
    # get msg content
    msg = ui.current_buffer.get_selected_message()
    msgtext = msg.accumulate_body()

    # translate
    import goslate
    gs = goslate.Goslate()
    tmsg = gs.translate(msgtext, targetlang)

    # replace message widgets content
    mt=ui.current_buffer.get_selected_messagetree()
    mt.replace_bodytext(tmsg)
    mt.refresh()

    # refresh the thread buffer
    ui.current_buffer.refresh()


from alot.helper import split_commandstring, call_cmd
from twisted.internet.defer import inlineCallbacks

@inlineCallbacks
def dimapseminar(ui):
    """interprets DIMAP seminar mails"""
    msg = ui.current_buffer.get_selected_message()
    msgtext = msg.accumulate_body()
    r=r"Title:\s*(?P<title>((.*)(\n\s*.*)*))\n\nSpeaker:\s*(?P<speaker>.*)\nTime:\s*(?P<time>.*)\nLocation:\s*(?P<location>.*)\n\s*Abstract:\s*(?P<abstract>((.*)\n)*)"
    info=re.search(r, msgtext).groupdict()
    info['title']=' '.join(info['title'].split())
    #ui.notify('info: %s' % str(info.items()))
    cmd = "gcalcli add " \
          "--calendar uni " \
          "--title \"DIMAP: {speaker}:{title}\" " \
          "--where \"{location}\" " \
          "--when \"{time}\" "\
          "--description \"{abstract}\" "\
          "--duration 60 "\
          "--reminder 30"
    cmdlist = split_commandstring(cmd.format(**info))
    msg = ui.notify('info: %s' % cmdlist)
    if (yield ui.choice("commit?", select='yes',
                        cancel='no')) == 'no':
        return
    ui.clear_notify([msg])
    ui.notify('info: %s' % str(call_cmd(cmdlist)))





