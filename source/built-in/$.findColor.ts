import _ = require('lodash')

// function

function format(string: string) {

  if (string.includes('0x')) {
    return string
  }

  string = _.trim(string, " '\"#")

  if (string.length === 3) {
    string = [
      _.repeat(string[0], 2),
      _.repeat(string[1], 2),
      _.repeat(string[2], 2)
    ].join('')
  }

  return `0x${string.toUpperCase()}`

}

// export
export default (
  { argument, output }: { argument: string[], output: string }
) => {

  // output
  const [oX, oY] = _.trim(output, ' []')
    .replace(/\s/g, '')
    .split(',')

  // argument
  let [target, x1, y1, x2, y2, variation] = argument
  x1 = x1 || '0'
  y1 = y1 || '0'
  x2 = x2 || 'A_ScreenWidth'
  y2 = y2 || 'A_ScreenHeight'
  variation = variation || '0'

  if (target.startsWith('"#')) {
    target = format(target)
  }

  return `PixelSearch ${oX}, ${oY},
  ${x1}, ${y1}, ${x2}, ${y2},
  ${target}, ${variation}, Fast RGB`

}