// interface
import { IArgumentBuiltIn } from '../type'

// export

export function $write({ argument }: IArgumentBuiltIn) {
  return `FileAppend ${argument[1] || ''}, ${argument[0] || 'readme.txt'}, 'UTF-8-RAW'`
}