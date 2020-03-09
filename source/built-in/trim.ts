// interface
import { iArgumentBuiltIn } from '../type'

// export

export function $trim({ argument }: iArgumentBuiltIn) {
  return `Trim ${argument[0]}`
}

export function $trimEnd({ argument }: iArgumentBuiltIn) {
  return `RTrim ${argument[0]}`
}

export function $trimStart({ argument }: iArgumentBuiltIn) {
  return `LTrim ${argument[0]}`
}