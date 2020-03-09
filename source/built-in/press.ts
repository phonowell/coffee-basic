import { formatKey } from '../module/fn'

// interface
import { iArgumentBuiltIn } from '../type'

// export

export function $isPressing({ argument, output }: iArgumentBuiltIn) {

  const key = argument[0]
    .replace(/['"]/g, '')

  return [
    `GetKeyState __value__, ${formatKey(key)}`,
    `${output} = __value__ == \"D\"`
  ]

}

export function $press({ argument }: iArgumentBuiltIn) {

  let listResult = []
  for (const arg of argument) {

    const list = arg
      .replace(/\s/g, '')
      .split('+')

    const max = list.length - 1
    let listPre = []

    for (const _i in list) {

      const i = parseInt(_i)
      const key = list[i]

      if (i < max) {
        listPre.push(key)
        listResult.push(formatKey(`${key}:down`))
        continue
      }

      listResult.push(formatKey(key))

    }

    listPre.reverse()
    for (const key of listPre) {
      listResult.push(formatKey(`${key}:up`))
    }

  }

  return `Send {${listResult.join('}{')}}`

}