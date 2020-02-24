import $ = require('fire-keeper')

// export
export default async (path: string, cont: string) => {

  const { basename, dirname } = $.getName(path)
  const extname = '.ahk'

  await $.write_(`${dirname}/${basename}${extname}`, cont)

}