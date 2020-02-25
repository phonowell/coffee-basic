// interface
import { iData } from '../type'

// const

const listForbidden = [
  'then',
  'until',
  'when',
  'while'
]

// function

function log(message: string, i: number) {
  console.log(`line ${i + 1}: ${message}`)
  return message
}

// export
export default (data: iData) => {

  let result = true

  const listRaw = data.raw.split('\n')
  for (const i in listRaw) {

    const line = listRaw[i]

    // block comment
    if (line.includes('###')) {
      log('found block comment', parseInt(i))
      result = false
    }

    // skip comment
    if (line.trim().startsWith('#')) {
      continue
    }

    // forbidden words
    for (const word of listForbidden) {
      if (!line.includes(word)) {
        continue
      }
      log(`found forbidden word '${word}'`, parseInt(i))
      result = false
    }

  }

  return result

}