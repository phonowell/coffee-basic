// interface
import { IArgumentBuiltIn } from '../type'

// export

export function $alert({ argument }: IArgumentBuiltIn) {
  return `MsgBox % ${argument[0]}`
}

export function $info({ argument }: IArgumentBuiltIn) {
  return `TrayTip % ${argument[0]}`
}

export function $tip({ argument }: IArgumentBuiltIn) {

  if (!argument[0]) {
    return 'ToolTip'
  } else {
    return `ToolTip % ${argument.join(', ')}`
  }

}