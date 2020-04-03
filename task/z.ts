import $ from '../lib/fire-keeper'

// export
export default async () => {

  // const [source, isBare] = ['./script/ffxiv/pld/index.coffee', false]
  const [source, isBare] = ['./script/test/z.coffee', true]

  const parseAsync = $.require('./source/index')
  await parseAsync(source, {
    bare: isBare
  })

}