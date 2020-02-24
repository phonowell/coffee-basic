import $ = require('fire-keeper')

// export
export default async (path: string) => {

  const extname = '.coffee'
  if (!path.includes(extname)) {
    path += extname
  }

  return await $.read_(path) as string

}