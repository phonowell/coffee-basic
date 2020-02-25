import $ = require('fire-keeper')

// export
module.exports = async () => {

  await $.remove_('./script/**/*.ahk')

  const parse_ = $.require('./source/index')

  await parse_([
    './script/*.coffee',
    './script/ffxiv/**/index.coffee',
    './script/other/*.coffee',
    './script/test/*.coffee'
  ])

}