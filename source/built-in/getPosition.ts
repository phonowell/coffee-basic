import _ = require('lodash')

// interface
import { iArgumentBuiltIn } from '../type'

// export
export default ({ output }: iArgumentBuiltIn) => {

  const [x, y] = _.trim(output, ' []')
    .replace(/\s/g, '')
    .split(',')

  return `MouseGetPos ${x}, ${y}`

}