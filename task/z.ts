import $ from '../source/fire-keeper'

// export
module.exports = async () => {

  const parseAsync = $.require('./source/index')
  await parseAsync('./script/test/z.coffee', {
    bare: true
  })

}