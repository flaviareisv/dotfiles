import { existsSync, appendFile } from 'fs'
import { join } from 'path'
import { ifStringFile } from './utils'
import * as chalk from 'chalk'
import { log } from 'console'

export class Setup {
    private home: string
    private dirDotfile: string

    constructor() {
        log(chalk.default.bold('Starting'))
        this.home = process.env['HOME']
        this.dirDotfile = join(this.home, 'dotfiles', 'config')
    }

    async setConfigProfile(): Promise<boolean> {
        let profile: string

        log(chalk.default.yellow('Set configuration in profile'))

        if (existsSync(join(this.home, '.profile')) === true) {
            profile = join(this.home, '.profile')
        }
        else {
            profile = join(this.home, '.bash_profile')
        }

        const dotProfile = join(this.dirDotfile, 'profile')
        const contentProfile = `. ${dotProfile} \n`

        log(chalk.default.yellow('Profile is set...'))

        const sFile = await ifStringFile(profile, contentProfile)

        if (!sFile) {
            appendFile(profile, contentProfile, (err) => {
                if (err) throw false
            })
        }

        return true
    }
}