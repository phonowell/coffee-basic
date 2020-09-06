import { trim } from '../transpiler/fn'

// interface

import { ArgumentBuiltIn } from '../type'

// function

export function $open(
  { argument, output }: ArgumentBuiltIn
): string[] {
  const arg = trim(argument[0])
  const result = [`Run ${arg}`]
  if (output)
    result.push(`${output} = ${arg}`)
  return result
}

export function $write(
  { argument }: ArgumentBuiltIn
): string {
  return `FileAppend ${argument[1] || ''}, ${argument[0] || 'readme.txt'}, 'UTF-8-RAW'`
}