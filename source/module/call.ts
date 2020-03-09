import { getDepth, setDepth } from './fn'

// interface
import { iData } from '../type'

// function

function filterType(line: string) {

  let type: string

  if (line.startsWith('return ')) {
    type = 'return'
    line = line
      .replace('return ', '')
  } else if (line.startsWith('if (')) {
    type = 'if'
    line = line
      .replace('if (', '')
  } else if (line.startsWith('if !(')) {
    type = 'unless'
    line = line
      .replace('if !(', '')
  } else if (line.startsWith('else if (')) {
    type = 'else-if'
    line = line
      .replace('else if (', '')
  }

  line = line
    .replace(') {', '')

  return [type, line]

}

function format(line: string) {

  const depth = getDepth(line)

  // remove await
  line = line
    .trim()
    .replace(/await\s+/g, '')

  // validate
  if (!validate(line)) {
    return `${setDepth(depth)}${line}`
  }

  let type: string
  [type, line] = filterType(line)

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

  if (type === 'return') {
    result = `return ${result}`
  } else if (type === 'if') {
    result = `if (${result}) {`
  } else if (type === 'unless') {
    result = `if !(${result}) {`
  } else if (type === 'else-if') {
    result = `else if (${result}) {`
  }

  return `${setDepth(depth)}${result}`

}

function validate(string: string) {

  const list = [
    'else {',
    'loop '
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

  for (const _i in data.var) {
    const i = parseInt(_i)
    data.var[i] = format(data.var[i])
  }

  for (const block of [...data.fn, ...data.event]) {
    let list: string[] = []
    for (const line of block.content) {
      list.push(format(line))
    }
    block.content = list
  }

}