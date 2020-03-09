import { unquote } from './fn'

// interface
import { iBlock, iData, iOption } from '../type'

// function

function renderEvent(list: iBlock[]) {

  let result: string[] = []

  for (const block of list) {

    let content = []
    for (const line of block.content) {
      if (!line.trim()) {
        continue
      }
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

function renderFunction(list: iBlock[]) {

  let result: string[] = []

  for (const block of list) {

    let content = []
    for (const line of block.content) {
      if (!line.trim()) {
        continue
      }
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

function renderGlobalVariable(list: string[]) {

  let result: string[] = []

  for (const line of list) {
    result.push(unquote(`global ${line}`))
  }

  return result

}

// export
export default (data: iData, option: iOption = {}) => {

  let result: string[] = []

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
      'default()'
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

  for (const i in result) {
    result[i] = result[i].trimEnd()
  }

  return result
    .join('\n')
    .trim()
    .replace(/\n{2,}/g, '\n\n')
    .replace(/'/g, '"')
    .replace(/\s=\s/g, ' := ')

}