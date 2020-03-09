import { wrapName } from '../module/fn'

// interface
import { IArgumentBuiltIn, IData } from '../type'

// export

export function $clearInterval({ argument }: IArgumentBuiltIn, data: IData) {
  return `SetTimer ${wrapName(argument[0], data)}, Off`
}

export function $clearTimeout({ argument }: IArgumentBuiltIn, data: IData) {
  return `SetTimer ${wrapName(argument[0], data)}, Off`
}

export function $setInterval({ argument }: IArgumentBuiltIn, data: IData) {
  return `SetTimer ${wrapName(argument[0], data)}, % ${argument[1] || 0}`
}

export function $setTimeout({ argument }: IArgumentBuiltIn, data: IData) {
  return `SetTimer ${wrapName(argument[0], data)}, % 0 - ${argument[1] || 0}`
}