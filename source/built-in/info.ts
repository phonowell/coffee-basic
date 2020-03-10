import _ = require('lodash')

import { callFn, regFn } from '../module/fn'

// interface
import { IArgumentBuiltIn, IData } from '../type'

// export

export function $alert({ argument, output }: IArgumentBuiltIn, data: IData) {
  const fn = regFn(data, '$alert', 'msg', [
    'MsgBox % msg',
    'return msg'
  ])
  return callFn(fn, output, argument)
}

export function $info({ argument, output }: IArgumentBuiltIn, data: IData) {
  const fn = regFn(data, '$info', 'msg', [
    'TrayTip % msg',
    'return msg'
  ])
  return callFn(fn, output, argument)
}

export function $tip({ argument, output }: IArgumentBuiltIn, data: IData) {
  const fn = regFn(data, '$tip', 'msg', [
    'ToolTip % msg',
    'return msg'
  ])
  return callFn(fn, output, argument)
}