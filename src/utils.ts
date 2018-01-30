import { readFile } from 'fs'

export function ifStringFile(file: string, search: string): Promise<boolean> {
    return new Promise((resolve, reject) => {
        let resSearch = false

        readFile(file, (err, data) => {
            if (err) {
                return reject(false)
            }
            if (data.indexOf(search) === -1) {
                resSearch = false
            }
            else {
                resSearch = true
            }
        })
        return resolve(resSearch)
    })
}