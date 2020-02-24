import iconv = require('iconv-lite')

import read_ from './read_'
import transpile_ from './transpile_'
import write_ from './write_'

// interface

interface iOption {
  bare?: boolean
  path?: string
}

// function

class Parser {

  read_ = read_
  transpile_ = transpile_
  write_ = write_

  // ---

  async execute_(path: string, option: iOption) {

    const source: string = await this.read_(path)
    Object.assign(option, { path })
    let cont: string = await this.transpile_(source, option)
    cont = iconv.encode(cont, 'utf8', {
      addBOM: true
    }).toString()
    await this.write_(path, cont)

    return cont

  }

}

// export
module.exports = async (source: string, option: iOption = {}) => {
  return await new Parser().execute_(source, option)
}