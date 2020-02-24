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
export default () => {

  let result = true

  const list = this.raw.split('\n')
  for (const i in list) {

    const line = list[i]

    // comment
    if (line.includes('###')) {
      log('found block comment', parseInt(i))
      result = false
    }
    if (line.trim()[0] === '#') {
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