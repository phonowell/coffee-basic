import $ from 'fire-keeper'

// function

async function read_(
  source: string
): Promise<string> {

  const extname = '.coffee'
  if (!source.includes(extname))
    throw new Error(`invalid source '${source}'`)

  const cont = await $.read_(source) as string

  if (!cont)
    throw new Error(`invalid source '${source}'`)

  return cont
}

async function write_(
  source: string,
  content: string
): Promise<void> {

  const { basename, dirname } = $.getName(source)
  const extname = '.ahk'

  await $.write_(`${dirname}/${basename}${extname}`, content)
}

// export
export {
  read_,
  write_
}