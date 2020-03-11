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
  const fn = regFn(data, '$tip', ["msg = ''", 'x = -1', 'y = -1'], [
    'if (x >= 0 and y >= 0) {',
    '  ToolTip % msg, x, y',
    '}',
    'else {',
    '  ToolTip % msg',
    '}',
    'return msg'
  ])
  return callFn(fn, output, argument)
}