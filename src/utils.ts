import { readFileSync } from 'fs'

export function ifStringFile(file: string, search: string): Promise<boolean> {
    return new Promise((resolve, reject) => {
        let resSearch = false
        try {
            const occurred = readFileSync(file)
            const res = occurred.indexOf(search)
            if (res !== -1) resSearch = true
            return resolve(resSearch)
        }
        catch(e) {
            return reject(resSearch)
        }
    })
}

export function sleep(ms: number) {
    return new Promise(resolve => setTimeout(resolve, ms))
}