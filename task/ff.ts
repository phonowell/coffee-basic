import $ from '../lib/fire-keeper'
import * as _ from 'lodash'

// function

const load_ = async () => {

  const listResult = [] as {
    title: string
    value: string
  }[]

  for (const source of await $.source_('./script/ffxiv/**/index.coffee')) {

    const dirname = $.getBasename($.getDirname(source))

    listResult.push({
      title: dirname,
      value: source
    })
  }

  return listResult
}

// export
export default async () => {

  // ask

  const { target } = $.argv()
  const list = await load_()

  const source = target ? _.find(list, { title: target }).value : await $.prompt_({
    id: 'target-ff',
    list: await load_(),
    type: 'auto'
  })

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