import _ = require('lodash')

// interface
import { IArgumentBuiltIn, IData } from '../type'

// export

export function $alert({ argument, output }: IArgumentBuiltIn, data: IData) {
  const result = [
    `MsgBox % ${argument[0]}`
  ]
  if (output) {
    result.push(`${output} = ${argument[0]}`)
  }
  return result
}

export function $info({ argument, output }: IArgumentBuiltIn, data: IData) {
  const result = [
    `TrayTip % ${argument[0]}`
  ]
  if (output) {
    result.push(` = ${argument[0]}`)
  }
  return result
}

export function $prompt({ argument, output }: IArgumentBuiltIn, data: IData) {
  const [message, value] = argument
  return `InputBox ${output}, , % ${message || ''}, , , , , , , , % ${value || ''}`
}

export function $tip({ argument, output }: IArgumentBuiltIn, data: IData) {
  const result = [] as string[]
  if (!argument[0]) {
    result.push('ToolTip')
  } else {
    if (argument[1] || argument[2]) {
      result.push(`ToolTip % ${argument[0]}, ${argument[1] || 0}, ${argument[2] || 0}`)
    } else {
      result.push(`ToolTip % ${argument[0]}`)
    }
  }
  if (output) {
    result.push(`${output} = ${argument[0]}`)
  }
  return result
}