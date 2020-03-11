import $ from '../source/fire-keeper'

// export
module.exports = async () => {

  const parseAsync = $.require('./source/index')

  $.watch('./script/ffxiv/**/*.coffee', async (e: { path: string }) => {
    const dirname = $.getDirname(e.path)
    const basename = $.getBasename(dirname)
    const source = `${dirname}/index.coffee`
    const target = `${dirname}/index.ahk`
    await parseAsync(source)
    await $.write_(`${dirname}/${basename}.ahk`, await $.read_(target))
    await $.remove_(target)
  })

  $.watch('./script/test/*.coffee', async (e: { path: string }) => {
    await parseAsync(e.path)
  })

}