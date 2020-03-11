import $ from '../source/fire-keeper'

// export
export default async (source: string, content: string) => {

  const { basename, dirname } = $.getName(source)
  const extname = '.ahk'

  await $.write_(`${dirname}/${basename}${extname}`, content)

}