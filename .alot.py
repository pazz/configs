def pre_exit(ui, dbman, accountman, config):
    accounts = accountman.get_accounts()
    if accounts:
        ui.logger.info('goodbye, %s!' % accounts[0].realname)
    else:
        ui.logger.info('goodbye!')
