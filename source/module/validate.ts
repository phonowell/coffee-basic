import $ from '../../lib/fire-keeper'

// interface
import { IData } from '../type'

// const

const listForbidden = [
  '::',
  '=>',
  '@',
  'case',
  'class',
  'exclude',
  'export',
  'import',
  'include',
  'interface',
  'prototype',
  'switch',
  'until',
  'when',
  'while'
]

// function

const log = (message: string, i: number) => {
  $.i(`line ${i + 1}: ${message}`)
  return message
}

// export
export default (data: IData) => {

  let result = true

  const listRaw = data.raw.split('\n')
  listRaw.forEach((line, i) => {

    // block comment
    if (line.includes('###')) {
      log('found block comment', i)
      result = false
    }

    // skip comment
    if (line.trim().startsWith('#')) return

    if (line.includes('# ')) {
      log('found inline comment', i)
      result = false
    }

    // forbidden words
    for (const word of listForbidden) {
      if (!line.includes(word)) continue
      log(`found forbidden word '${word}'`, i)
      result = false
    }
  })

  return result
}