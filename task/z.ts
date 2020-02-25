import $ = require('fire-keeper')

// export
module.exports = async () => {

  await $.remove_('./script/test/*.ahk')
  const parse_ = $.require('./source/index')
  await parse_('./script/test/build-in.coffee')

}