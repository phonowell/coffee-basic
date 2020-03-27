import $ from '../source/fire-keeper'

// export
module.exports = async () => {

  const source = './script/ffxiv/rdm/index.coffee'
  // const source = './script/test/z.coffee'

  const parseAsync = $.require('./source/index')
  await parseAsync(source, {
    bare: false
  })

}