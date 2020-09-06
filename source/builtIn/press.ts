import { formatKey } from '../transpiler/fn'

// interface

import { ArgumentBuiltIn } from '../type'

// function

export function $isPressing(
  { argument, output }: ArgumentBuiltIn
): string[] {

  if (!output) throw new Error('found no output')

  const key = argument[0]
    .replace(/['"]/g, '')

  return [
    `GetKeyState __value__, ${formatKey(key)}`,
    `${output} = __value__ == \"D\"`
  ]
}

export function $press(
  { argument }: ArgumentBuiltIn
): string {

  const listResult: string[] = []
  for (const arg of argument) {

    const list = arg
      .replace(/\s/g, '')
      .split('+')

    const max = list.length - 1
    const listPre = [] as string[]

    list.forEach((key, i) => {

      if (i < max) {
        listPre.push(key)
        listResult.push(formatKey(`${key}:down`))
        return
      }

      listResult.push(formatKey(key))
    })

    listPre.reverse()
    for (const key of listPre)
      listResult.push(formatKey(`${key}:up`))
  }

  return `Send {${listResult.join('}{')}}`
}