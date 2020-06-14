import { getDepth } from './fn'

// interface
import { IData } from '../type'

// function

const pickData = (line: string) => {

  if (getDepth(line)) return
  if (!line.includes('=')) return
  if (line.includes('->')) return

  const [key, value] = line
    .split('=')
    .map(it => it.trim())
  if (key.search(/[\s\{\}\(\)\[\]\.,'"]/) !== -1) return

  return [key, value] as [string, string]
}

// export
export default (data: IData) => {

  const content = [] as string[]

  for (const line of data.main) {
    const [key, value] = pickData(line) || []

    if (!(key && value)) {
      content.push(line)
      continue
    }

    if (value.includes('[')) {
      value
        .replace(/[\[\]]/g, '')
        .split(',')
        .map(it => it.trim())
        .forEach((it, i) => content.push(`${key}[${i}] = ${it}`))
      data.var.push(`${key} = []`)
      continue
    }

    data.var.push(`${key} = ${value}`)
  }

  data.main = content
}