import $ = require('fire-keeper')

// export
module.exports = async () => {

  await $.remove_('./script/**/*.ahk')

  const parse_ = $.require('./source/index')

  const listSource = [
    './script/*.coffee',
    './script/ffxiv/**/index.coffee',
    './script/other/*.coffee',
    './script/test/*.coffee'
  ]
  for (const source in await $.source_(listSource)) {
    await parse_(source)
  }

}