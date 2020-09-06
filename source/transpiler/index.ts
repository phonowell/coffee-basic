import initData from './init'
import injectInclude_ from './include'
import validate from './validate'
import pickMode from './pickMode'
import formatMain from './format'
import pickGlobalVariable from './pickGlobalVariable'
import pickFunction from './pickFunction'
import pickEvent from './pickEvent'
import wrapMain from './wrapMain'
import setHead from './setHead'
import setFoot from './setFoot'
import replaceIf from './replaceIf'
import replaceFor from './replaceFor'
import replaceLoop from './replaceLoop'
import call from './call'
import injectBuiltIn from './inject'
import render from './render'

// interface

import { Option } from '../type'

// function

async function main_(
  content: string,
  option: Option
): Promise<string> {

  const data = initData()
  data.raw = await injectInclude_(content, option)
  data.main = data.raw.split('\n')

  if (!validate(data.raw)) return ''

  data.mode = pickMode(data.main)
  data.main = formatMain(data.main)

  Object.assign(data, pickGlobalVariable(data.main))
  Object.assign(data, pickFunction(data.main))
  Object.assign(data, pickEvent(data.main))

  wrapMain(data.main, data.fn)
  data.head = setHead(data.mode)
  data.foot = setFoot()

  const listBlock = [...data.event, ...data.fn]
  replaceIf(listBlock,)
  replaceFor(listBlock)
  replaceLoop(listBlock)

  call(data.var, listBlock)
  injectBuiltIn(listBlock)

  return render(data, option)
}

// export
export default main_