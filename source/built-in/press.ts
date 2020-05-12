import { formatKey } from '../module/fn'

// interface
import { IArgumentBuiltIn } from '../type'

// export

export function $isPressing({ argument, output }: IArgumentBuiltIn) {

  if (!output) throw new Error('found no output')

  const key = argument[0]
    .replace(/['"]/g, '')

  return [
    `GetKeyState __value__, ${formatKey(key)}`,
    `${output} = __value__ == \"D\"`
  ]
}

export function $press({ argument }: IArgumentBuiltIn) {

  const listResult = [] as string[]
  for (const arg of argument) {

    const list = arg
      .replace(/\s/g, '')
      .split('+')

    const max = list.length - 1
    const listPre = [] as string[]

    for (const _i in list) {
      if (!list.hasOwnProperty(_i)) continue

      const i = parseInt(_i, 10)
      const key = list[i]

      if (i < max) {
        listPre.push(key)
        listResult.push(formatKey(`${key}:down`))
        continue
      }

      listResult.push(formatKey(key))
    }

    listPre.reverse()
    for (const key of listPre)
      listResult.push(formatKey(`${key}:up`))
  }

  return `Send {${listResult.join('}{')}}`
}