// interface
import { iArgumentBuiltIn } from '../type'

// export
export default ({ argument }: iArgumentBuiltIn) => {

  let isFixed = 'Toggle'
  if (argument[0] == 'true') {
    isFixed = 'On'
  } else if (argument[0] == 'false') {
    isFixed = 'Off'
  }

  return `Winset AlwaysOnTop, ${isFixed}, A`

}