import $ = require('fire-keeper')

// export
module.exports = async () => {

  for (const source of await $.source_('./source/**/*.coffee')) {

    const target = source
      .replace('.coffee', '.ts')

    if (await $.isExisted_(target)) {
      continue
    }

    await $.write_(target, '')

  }

}