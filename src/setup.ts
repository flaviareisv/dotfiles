import { existsSync, appendFile } from 'fs'
import { join } from 'path'
import { ifStringFile } from './utils'

export class Setup {
    private home: string
    private dirDotfile: string

    constructor() {
        console.log('Starting')
        this.home = process.env['HOME']
        this.dirDotfile = join(this.home, 'dotfiles', 'config')
    }

    async setConfigProfile(): Promise<boolean> {
        let profile: string

        console.log('Set configuration in profile')

        if (existsSync(join(this.home, '.profile')) === true) {
            profile = join(this.home, '.profile')
        }
        else {
            profile = join(this.home, '.bash_profile')
        }

        const dotProfile = join(this.dirDotfile, 'profile')
        const contentProfile = `. ${dotProfile} \n`

        console.log('Profile is set...')

        const sFile = await ifStringFile(profile, contentProfile)

        if (!sFile) {
            appendFile(profile, contentProfile, (err) => {
                if (err) throw false
            })
        }

        return true
    }
}