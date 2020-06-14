import $ from '../lib/fire-keeper'

// export
export default async (source: string) => {

  const extname = '.coffee'
  if (!source.includes(extname))
    throw new Error(`invalid source '${source}'`)

  const cont = await $.read_(source) as string

  if (!cont)
    throw new Error(`invalid source '${source}'`)

  return cont
}