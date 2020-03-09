// interface
import { iArgumentBuiltIn } from '../type'

// export

export function $info({ argument }: iArgumentBuiltIn) {
  return `TrayTip % ${argument[0]}`
}

export function $tip({ argument }: iArgumentBuiltIn) {

  if (!argument[0]) {
    return 'ToolTip'
  } else {
    return `ToolTip % ${argument.join(', ')}`
  }

}