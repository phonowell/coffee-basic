import $ = require('fire-keeper')

// export
module.exports = async () => {

  const parse_ = $.require('./source/index')

  $.watch('./script/ffxiv/**/*.coffee', async (e: { path: string }) => {
    const dirname = $.getDirname(e.path)
    await parse_(`${dirname}/index.coffee`)
  })

  $.watch('./script/ffxiv/**/index.ahk', async (e: { path: string }) => {
    const dirname = $.getDirname(e.path)
    const basename = $.getBasename(dirname)
    await $.write_(`${dirname}/${basename}.ahk`, await $.read_(e.path))
    await $.remove_(e.path)
  })

}