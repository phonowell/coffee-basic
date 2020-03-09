import $ = require('fire-keeper')

// export
module.exports = async () => {

  await $.remove_('./script/**/*.ahk')

  const parseAsync = $.require('./source/index')

  await parseAsync([
    './script/*.coffee',
    './script/ffxiv/**/index.coffee',
    './script/other/*.coffee'
  ])

  for (const source of await $.source_('./script/ffxiv/**/index.ahk')) {
    const dirname = $.getDirname(source) as string
    const basename = $.getBasename(dirname) as string
    await $.write_(`${dirname}/${basename}.ahk`, await $.read_(source))
    await $.remove_(source)
  }

  await parseAsync('./script/test/*.coffee', {
    bare: true
  })

}