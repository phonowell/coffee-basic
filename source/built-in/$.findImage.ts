import _ = require('lodash')

// export
export default (
  { argument, output }: { argument: string[], output: string }
) => {

  // output
  const [oX, oY] = _.trim(output, ' []')
    .replace(/\s/g, '')
    .split(',')

  // argument
  let [target, x1, y1, x2, y2] = argument
  x1 = x1 || '0'
  y1 = y1 || '0'
  x2 = x2 || 'A_ScreenWidth'
  y2 = y2 || 'A_ScreenHeight'

  target = target
    .replace(/\//g, '\\')

  return `ImageSearch ${oX}, ${oY},
  ${x1}, ${y1}, ${x2}, ${y2},
  % A_ScriptDir . \"\\\" . ${target}`

}