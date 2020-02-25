import $ = require('fire-keeper')

// export
export default () => {

  const parse_ = $.require('./source/index')

  const listSource = [
    './script/*.coffee',
    './source/other/*.coffee',
    './script/test/*.coffee'
  ]

  $.watch(listSource, async (e: { path: string }) => {
    await parse_(e.path)
  })

  $.watch('./script/ffxiv/**/*.coffee', async (e: { path: string }) => {
    const dirname = $.getDirname(e.path)
    await parse_(`${dirname}/index.coffee`)
  })

}