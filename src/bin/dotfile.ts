#!/usr/bin/env node

import * as cmd from 'commander'
import { Setup } from '../setup'
import * as ora from 'ora'
import { sleep } from '../utils'

cmd.version('{{ version }}')

cmd
    .command('apply')
    .description('Apply configuration in home')
    .action(async () => {
        const spn = ora('Starting').start()
        await sleep(3000)
        spn.succeed()

        await startConfigProfile()
        await startConfigBash()
    })

cmd.parse(process.argv)

if (!cmd.args.length) cmd.help()

async function startConfigProfile() {
    const st = new Setup()
    const spnProf = ora('Setting profile file..').start()

    try {    
        await st.setConfigProfile()
        spnProf.succeed('Profile configuration succeed')
    }
    catch {
        spnProf.fail('Not set profile in file')
    }
}

async function startConfigBash() {
    const st = new Setup()
    const spnBash = ora('Setting bash file..').start()

    try {
        await st.setConfigBash()
        spnBash.succeed('Bash configuration succeed')
    }
    catch {
        spnBash.fail('Not set bash in file')
    }
}