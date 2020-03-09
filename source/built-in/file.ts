// interface
import { iArgumentBuiltIn } from '../type'

// export

export function $write({ argument }: iArgumentBuiltIn) {
  return `FileAppend ${argument[1] || ''}, ${argument[0] || 'readme.txt'}, 'UTF-8-RAW'`
}