import $ = require('fire-keeper')

// export
module.exports = async () => {

  const parse_ = $.require('./source/index')
  await parse_('./script/test/z.coffee', {
    bare: true
  })

}