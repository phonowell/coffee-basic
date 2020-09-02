import $ from 'fire-keeper'
import _ from 'lodash'

// interface

type Item = {
  title: string
  value: string
}

// function

async function load_(): Promise<Item[]> {

  const listResult: Item[] = []

  for (const source of await $.source_('./script/ffxiv/**/index.coffee')) {

    const dirname = $.getBasename($.getDirname(source))

    listResult.push({
      title: dirname,
      value: source
    })
  }

  return listResult
}

async function main_(): Promise<void> {

  // ask

  const { target }: {
    target: string | undefined
  } = $.argv()
  const list = await load_()

  let source: string = ''
  if (typeof target === 'string') {
    const it = _.find(list, { title: target })
    if (it) source = it.value
  } else
    source = await $.prompt_({
      id: 'target-ff',
      list: await load_(),
      type: 'auto'
    })
  if (!source) throw new Error(`invalid source '${source}'`)

  // compile

  const dirname = $.getDirname(source)
  const basename = $.getBasename(dirname)

  await $.remove_(`${dirname}/*.ahk`)

  const parseAsync = (await import('../source/index')).default
  await parseAsync(source)

  const temp = `${dirname}/index.ahk`
  await $.write_(`${dirname}/${basename}.ahk`, await $.read_(temp))
  await $.remove_(temp)
}

// export
export default main_