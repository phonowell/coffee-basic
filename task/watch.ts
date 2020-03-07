import $ = require('fire-keeper')

// export
module.exports = async () => {

  const parse_ = $.require('./source/index')

  $.watch('./script/ffxiv/**/*.coffee', async (e: { path: string }) => {
    const dirname = $.getDirname(e.path) as string
    const basename = $.getBasename(dirname) as string
    const source = `${dirname}/index.coffee`
    const target = `${dirname}/index.ahk`
    await parse_(source)
    await $.write_(`${dirname}/${basename}.ahk`, await $.read_(target))
    await $.remove_(target)
  })

  $.watch('./script/test/*.coffee', async (e: { path: string }) => {
    await parse_(e.path)
  })

}