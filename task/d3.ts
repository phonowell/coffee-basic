import $ from 'fire-keeper'

// function

async function main_(): Promise<void> {

  const base = './script/d3'

  // compile

  await $.remove_(`${base}/*.ahk`)

  const parseAsync = (await import('../source/index')).default
  await parseAsync(`${base}/index.coffee`, {
    bare: true
  })
}

// export
export default main_