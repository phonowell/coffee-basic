import $ = require('fire-keeper')

// export
export default async (source: string, content: string) => {

  const { basename, dirname }: {
    basename: string, dirname: string
  } = $.getName(source)
  const extname = '.ahk'

  await $.write_(`${dirname}/${basename}${extname}`, content)

}