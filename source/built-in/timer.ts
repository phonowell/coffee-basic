import { wrapName } from '../module/fn'

// interface
import { iArgumentBuiltIn, iData } from '../type'

// export

export function $clearInterval({ argument }: iArgumentBuiltIn, data: iData) {
  return `SetTimer ${wrapName(argument[0], data)}, Off`
}

export function $clearTimeout({ argument }: iArgumentBuiltIn, data: iData) {
  return `SetTimer ${wrapName(argument[0], data)}, Off`
}

export function $setInterval({ argument }: iArgumentBuiltIn, data: iData) {
  return `SetTimer ${wrapName(argument[0], data)}, % ${argument[1] || 0}`
}

export function $setTimeout({ argument }: iArgumentBuiltIn, data: iData) {
  return `SetTimer ${wrapName(argument[0], data)}, % 0 - ${argument[1] || 0}`
}