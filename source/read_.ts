import $ = require('fire-keeper')

// export
export default async (source: string) => {

  const extname = '.coffee'
  if (!source.includes(extname)) {
    throw new Error(`invalid extname '${extname}'`)
  }

  return await $.read_(source) as string

}