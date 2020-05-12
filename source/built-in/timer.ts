import { encodeFnName } from '../module/fn'

// interface
import { IArgumentBuiltIn, IData } from '../type'

// export

export function $clearInterval({ argument }: IArgumentBuiltIn, data: IData) {
  if (argument[0].includes('['))
    return [
      `__timer__ = ${argument[0]}`,
      'SetTimer %__timer__%, Off'
    ]
  else if (argument[0].includes('.'))
    return `SetTimer ${encodeFnName(argument[0])}, Off`
  else
    return `SetTimer ${argument[0]}, Off`
}

export function $clearTimeout({ argument }: IArgumentBuiltIn, data: IData) {
  if (argument[0].includes('['))
    return [
      `__timer__ = ${argument[0]}`,
      'SetTimer %__timer__%, Off'
    ]
  else if (argument[0].includes('.'))
    return `SetTimer ${encodeFnName(argument[0])}, Off`
  else
    return `SetTimer ${argument[0]}, Off`
}

export function $setInterval({ argument }: IArgumentBuiltIn, data: IData) {
  if (argument[0].includes('['))
    return [
      `__timer__ = ${argument[0]}`,
      `SetTimer %__timer__%, % ${argument[1] || 0}`
    ]
  else if (argument[0].includes('.'))
    return `SetTimer ${encodeFnName(argument[0])}, % ${argument[1] || 0}`
  else
    return `SetTimer ${argument[0]}, % ${argument[1] || 0}`
}

export function $setTimeout({ argument }: IArgumentBuiltIn, data: IData) {
  if (argument[0].includes('['))
    return [
      `__timer__ = ${argument[0]}`,
      `SetTimer %__timer__%, % 0 - ${argument[1] || 0}`
    ]
  else if (argument[0].includes('.'))
    return `SetTimer ${encodeFnName(argument[0])}, % 0 - ${argument[1] || 0}`
  else
    return `SetTimer ${argument[0]}, % 0 - ${argument[1] || 0}`
}