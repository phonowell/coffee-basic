// interface
import { IArgumentBuiltIn } from '../type'

// export

export function $trim({ argument }: IArgumentBuiltIn) {
  return `Trim ${argument[0]}`
}

export function $trimEnd({ argument }: IArgumentBuiltIn) {
  return `RTrim ${argument[0]}`
}

export function $trimStart({ argument }: IArgumentBuiltIn) {
  return `LTrim ${argument[0]}`
}