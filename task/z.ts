import $ from '../source/fire-keeper'

// export
module.exports = async () => {

  const parseAsync = $.require('./source/index')
  await parseAsync('./script/ffxiv/craft/index.coffee')

}