import init from './module/init'
import include_ from './module/include_'
import validate from './module/validate'
import pickMode from './module/pickMode'
import format from './module/format'
import pickGlobalVariable from './module/pickGlobalVariable'
import pickFunction from './module/pickFunction'
import pickEvent from './module/pickEvent'
import setMain from './module/setMain'
import setHead from './module/setHead'
import setFoot from './module/setFoot'
import replaceIf from './module/replaceIf'
import replaceFor from './module/replaceFor'
import replaceLoop from './module/replaceLoop'
import call from './module/call'
import buildIn from './module/build-in'
import render from './module/render'

// interface

import { iOption } from './type'

// function

async function execute_(content: string, option: iOption) {

  const data = init(content)

  await include_(data, option)

  if(!validate(data)){
    return ''
  }

  pickMode(data)
  format(data)

  pickGlobalVariable(data)
  pickFunction(data)
  pickEvent(data)

  setMain(data)
  setHead(data)
  setFoot(data)

  replaceIf(data)
  replaceFor(data)
  replaceLoop(data)

  call(data)
  buildIn(data)

  return render(data, option)

}

// export
export default async (content: string, option: iOption) => {
  return await execute_(content, option)
}