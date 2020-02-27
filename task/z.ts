import $ = require('fire-keeper')

// export
module.exports = async () => {

  const parse_ = $.require('./source/index')
  await parse_([
    './script/ffxiv/rdm/index.coffee',
    './script/ffxiv/toolkit/index.coffee'
  ])

}