#!/usr/bin/env node

import * as cmd from 'commander'
import * as chalk from 'chalk'
import { log } from 'console'
import { Setup } from '../setup'

cmd.version('{{ version }}')

cmd
    .command('apply')
    .description('Apply configuration in home')
    .action(() => {
        const st = new Setup()
        st.setConfigProfile()
            .then((res) => {
                log(chalk.default.green('OK'))
            })
            .catch((err) => log(chalk.default.red('Ocurred an error in set configuration profile')))
    })

cmd.parse(process.argv)

if (!cmd.args.length) cmd.help()