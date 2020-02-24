import formatKey from '../fn/formatKey'

// export
export default (
  { argument }: { argument: string[] }
) => {

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