import { trim } from '../module/fn'

// interface
import { IArgumentBuiltIn } from '../type'

// export

export function $open({ argument, output }: IArgumentBuiltIn) {
  const arg = trim(argument[0])
  const result = [`Run ${arg}`]
  if (output)
    result.push(`${output} = ${arg}`)
  return result
}

export function $write({ argument }: IArgumentBuiltIn) {
  return `FileAppend ${argument[1] || ''}, ${argument[0] || 'readme.txt'}, 'UTF-8-RAW'`
}