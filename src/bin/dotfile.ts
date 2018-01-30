#!/usr/bin/env node

import * as cmd from 'commander'

cmd.version('2.0.0')

cmd
    .command('apply')
    .description('Apply configuration in home')
    .action(() => {
        console.log('Iniciando')
    })

cmd.parse(process.argv)

if (!cmd.args.length) cmd.help()