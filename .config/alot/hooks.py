import logging
def pre_exit(aman=None, **rest):
    accounts = aman.get_accounts()
    if accounts:
        logging.info('goodbye, %s!' % accounts[0].realname)
    else:
        logging.info('goodbye!')
