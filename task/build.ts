import $ = require('fire-keeper')

// export
module.exports = async () => {

  await $.remove_('./script/**/*.ahk')

  const parse_ = $.require('./source/index')

  await parse_([
    './script/*.coffee',
    './script/ffxiv/**/index.coffee',
    './script/other/*.coffee'
  ])

  for (const source of await $.source_('./script/ffxiv/**/index.ahk')) {
    const dirname = $.getDirname(source)
    const basename = $.getBasename(dirname)
    await $.write_(`${dirname}/${basename}.ahk`, await $.read_(source))
    await $.remove_(source)
  }

  await parse_('./script/test/*.coffee', {
    bare: true
  })

}