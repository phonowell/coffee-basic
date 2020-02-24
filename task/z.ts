import $ = require('fire-keeper')

// export
module.exports = async () => {

  const path = 'ffxiv/rdm/index'

  await $.remove_(`./script/${path}.ahk`)

  const parse_ = $.require('./source/index')
  for (const source in await $.source_(`./script/${path}.coffee`)) {
    await parse_(source, {
      bare: true
    })
  }

}