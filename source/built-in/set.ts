// interface
import { iArgumentBuiltIn } from '../type'

// export
export function $setFixed({ argument }: iArgumentBuiltIn) {

  let isFixed = 'Toggle'
  if (argument[0] == 'true') {
    isFixed = 'On'
  } else if (argument[0] == 'false') {
    isFixed = 'Off'
  }

  return `Winset AlwaysOnTop, ${isFixed}, A`

}