import _ = require('lodash')

// export
export default (
  { output }: { output: string }
) => {

  const [x, y] = _.trim(output, ' []')
    .replace(/\s/g, '')
    .split(',')

  return `MouseGetPos ${x}, ${y}`

}