import { unquote } from './fn'

// interface
import { IBlock, IData, IOption } from '../type'

// function

const renderEvent = (list: IBlock[]) => {

  let result = [] as string[]

  for (const block of list) {

    const content = []
    for (const line of block.content) {
      if (!line.trim()) continue
      content.push(`  ${unquote(line)}`)
    }

    result = [
      ...result,
      '',
      `${block.name}::`,
      ...content,
      'return'
    ]
  }

  return result
}

const renderFunction = (list: IBlock[]) => {

  let result = [] as string[]

  for (const block of list) {

    const content = []
    for (const line of block.content) {
      if (!line.trim()) continue
      content.push(`  ${unquote(line)}`)
    }

    result = [
      ...result,
      '',
      `${block.name}(${unquote(block.argument)}) {`,
      ...content,
      '}'
    ]
  }

  return result
}

const renderGlobalVariable = (list: string[]) => {

  const result = [] as string[]

  for (const line of list) {
    result.push(unquote(`global ${line}`))
  }

  return result
}

// export
export default (data: IData, option: IOption = {}) => {

  let result = [] as string[]

  // head
  if (!option.bare) {
    result = [
      ...result,
      ...data.head
    ]
  }

  // global variable
  if (data.var.length) {
    result = [
      ...result,
      '',
      '; global variable',
      '',
      ...(renderGlobalVariable(data.var))
    ]
  }

  // function
  if (data.fn.length) {
    result = [
      ...result,
      '',
      '; function',
      '',
      ...(renderFunction(data.fn))
    ]
  }

  // main
  if (data.main.join('\n').trim()) {
    result = [
      ...result,
      '',
      '; default',
      '__$default__()'
    ]
  }

  // event
  if (data.event.length) {
    result = [
      ...result,
      '',
      '; event',
      '',
      ...(renderEvent(data.event))
    ]
  }

  // foot
  if (!option.bare) {
    result = [
      ...result,
      '',
      ...data.foot
    ]
  }

  result.forEach((value, i) => {
    result[i] = value.trimEnd()
  })

  return result
    .join('\n')
    .trim()
    .replace(/\n{2,}/g, '\n\n')
    .replace(/'/g, '"')
    .replace(/\s=\s/g, ' := ')
}