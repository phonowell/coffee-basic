import $ = require('fire-keeper')

// export
module.exports = async () => {

  const parse_ = $.require('./source/index')

  $.watch('./script/ffxiv/**/*.coffee', async (e: { path: string }) => {
    const dirname = $.getDirname(e.path)
    await parse_(`${dirname}/index.coffee`)
  })

}