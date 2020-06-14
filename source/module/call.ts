import { getDepth, setDepth } from './fn'

// interface
import { IData } from '../type'

// function

const filterType = (line: string) => {

  let type: string

  if (line.startsWith('return ')) {
    type = 'return'
    line = line.replace('return ', '')
  } else if (line.startsWith('if (')) {
    type = 'if'
    line = line.replace('if (', '')
  } else if (line.startsWith('if !(')) {
    type = 'unless'
    line = line.replace('if !(', '')
  } else if (line.startsWith('else if (')) {
    type = 'else-if'
    line = line.replace('else if (', '')
  }

  line = line.replace(') {', '')

  return [type, line]
}

const format = (line: string) => {

  const depth = getDepth(line)

  // remove await
  line = line
    .trim()
    .replace(/await\s+/g, '')

  // validate
  if (!validate(line))
    return `${setDepth(depth)}${line}`

  let type: string
  [type, line] = filterType(line)

  let isInvalid: boolean

  let result = line
    .replace(/[^\s=\()\{},\+\-\*\/]+\s+[^=]+/g, (text) => {

      if (text.search(/[=<>]/) !== -1) return text

      const [key, ..._value] = text.split(' ')
      const value = (_value.join(' ')).trim()

      isInvalid = [
        key === 'if',
        key.endsWith(':'),
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
      if (isInvalid) return text
      if (isOriginal(key)) return `${key}.Call(${value})`
      return `${key}(${value})`
    })

  if (type === 'return')
    result = `return ${result}`
  else if (type === 'if')
    result = `if (${result}) {`
  else if (type === 'unless')
    result = `if !(${result}) {`
  else if (type === 'else-if')
    result = `else if (${result}) {`

  return `${setDepth(depth)}${result}`
}

const isOriginal = (name: string) => {
  if (!(name.includes('.') || name.includes('[')))
    return false

  if (name.startsWith('$.'))
    return false

  if (name.startsWith('Math.'))
    return false

  return true
}

const validate = (text: string) => {

  const list = [
    'else {',
    'for ',
    'loop '
  ]

  let result = true
  for (const key of list) {
    if (!text.includes(key)) continue
    result = false
    break
  }

  return result
}

// export
export default (data: IData) => {

  data.var = data.var.map(value => format(value));

  [...data.fn, ...data.event].forEach(block =>
    block.content = block.content.map(line => format(line))
  )
}