import * as _ from 'lodash'

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
  const [title, text] = argument.length === 2 ? argument : ['"coffee-basic/0.0.2"', argument[0]]
  const result = [
    `TrayTip % ${title}, % ${text}`
  ]
  if (output) {
    result.push(` = ${text}`)
  }
  return result
}

export function $prompt({ argument, output }: IArgumentBuiltIn, data: IData) {

  if (!output) {
    throw new Error('found no output')
  }

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