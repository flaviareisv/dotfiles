#!/usr/bin/env node

import * as cmd from 'commander'
import * as chalk from 'chalk'
import { log } from 'console'
import { Setup } from '../setup'
import * as ora from 'ora'

cmd.version('{{ version }}')

cmd
    .command('apply')
    .description('Apply configuration in home')
    .action(() => {
        const st = new Setup()

        log(chalk.default.bold('Starting'))
        log()
        log(chalk.default.yellow('Set configuration in profile...'))

        const spn = ora('Set is file').start()

        st.setConfigProfile()
            .then((res) => {
                spn.succeed('Profile configuration succeed')
            })
            .catch((err) => spn.fail('Not set profile in file'))
    })

cmd.parse(process.argv)

if (!cmd.args.length) cmd.help()