#!/usr/bin/env node

import * as cmd from 'commander'
import { Setup } from '../setup'

cmd.version('{{ version }}')

cmd
    .command('apply')
    .description('Apply configuration in home')
    .action(() => {
        const st = new Setup()
        st.setConfigProfile()
            .then((res) => {
                console.log('OK')
            })
            .catch((err) => console.log('Ocurred an error in set configuration profile'))
    })

cmd.parse(process.argv)

if (!cmd.args.length) cmd.help()