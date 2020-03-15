import $ from '../source/fire-keeper'

// export
module.exports = async () => {

  const source = './script/ffxiv/rdm/index.coffee'

  const parseAsync = $.require('./source/index')
  await parseAsync(source, {
    bare: true
  })

}