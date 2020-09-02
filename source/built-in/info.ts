import _ from 'lodash'

// interface

import { ArgumentBuiltIn } from '../type'

// function

export function $alert(
  { argument, output }: ArgumentBuiltIn
): string[] {

  const listResult = [
    `MsgBox % ${argument[0]}`
  ]
  if (output)
    listResult.push(`${output} = ${argument[0]}`)
  return listResult
}

export function $info(
  { argument, output }: ArgumentBuiltIn
): string[] {

  const [title, text] = argument.length === 2
    ? argument
    : ['"coffee-basic/0.0.3"', argument[0]]
  const listResult = [
    `TrayTip % ${title}, % ${text}`
  ]
  if (output)
    listResult.push(` = ${text}`)
  return listResult
}

export function $prompt(
  { argument, output }: ArgumentBuiltIn
): string {

  if (!output) throw new Error('found no output')
  const [message, value] = argument
  return `InputBox ${output}, , % ${message || ''}, , , , , , , , % ${value || ''}`
}

export function $tip(
  { argument, output }: ArgumentBuiltIn
): string[] {

  const listResult: string[] = []
  if (!argument[0])
    listResult.push('ToolTip')
  else
    if (argument[1] || argument[2])
      listResult.push(`ToolTip % ${argument[0]}, ${argument[1] || 0}, ${argument[2] || 0}`)
    else
      listResult.push(`ToolTip % ${argument[0]}`)
  if (output)
    listResult.push(`${output} = ${argument[0]}`)
  return listResult
}