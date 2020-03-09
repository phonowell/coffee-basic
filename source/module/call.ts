import { getDepth, setDepth } from './fn'

// interface
import { iData } from '../type'

// function

function format(line: string) {

  // remove await
  line = line
    .replace(/await\s+/g, '')

  // validate
  if (!validate(line)) {
    return line
  }

  const depth = getDepth(line)
  line = line.trim()

  let isIf: boolean
  let isUnless: boolean
  let isElseIf: boolean

  // if / unless / else if
  if (line.startsWith('if (')) {
    isIf = true
    line = line
      .replace('if (', '')
      .replace(') {', '')
  } else if (line.startsWith('if !(')) {
    isUnless = true
    line = line
      .replace('if !(', '')
      .replace(') {', '')
  } else if (line.startsWith('else if (')) {
    isElseIf = true
    line = line
      .replace('else if (', '')
      .replace(') {', '')
  }

  let isInvalid: boolean

  let result = line
    .replace(/[^\s=\()\{},\+\-\*\/]+\s+[^=]+/g, (text) => {

      if (~text.search(/[=<>]/)) {
        return text
      }

      const [key, ..._value] = text.split(' ')
      const value = (_value.join(' ')).trim()

      isInvalid = [
        key === 'if',
        // ---
        value === '!',
        value.startsWith('and '),
        value.startsWith('or '),
        value.startsWith('+ '),
        value.startsWith('- '),
        value.startsWith('* '),
        value.startsWith('/ '),
        value.startsWith('> '),
        value.startsWith('< '),
        value.startsWith('!= '),
        value.startsWith('== ')
      ].includes(true)
      if (isInvalid) {
        return text
      }

      return `${key}(${value})`

    })

  if (isIf) {
    result = `if (${result}) {`
  } else if (isUnless) {
    result = `if !(${result}) {`
  } else if (isElseIf) {
    result = `else if (${result}) {`
  }

  return `${setDepth(depth)}${result}`

}

function validate(string: string) {

  const list = [
    'else {',
    'loop ',
    'return'
  ]

  let result = true
  for (const key of list) {
    if (!string.includes(key)) {
      continue
    }
    result = false
    break
  }

  return result

}

// export
export default (data: iData) => {

  for (const i in data.var) {
    data.var[i] = format(data.var[i])
  }

  for (const block of [...data.fn, ...data.event]) {
    let list = []
    for (const line of block.content) {
      list.push(format(line))
    }
    block.content = list
  }

}