import $ = require('fire-keeper')

// export
module.exports = async () => {

  const a = { b: 2 }
  a.b = 1
  $.i(a)

}