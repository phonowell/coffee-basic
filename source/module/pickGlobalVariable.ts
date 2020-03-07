import getDepth from '../fn/getDepth'

// interface
import { iData } from '../type'

// function

function pickData(line: string) {

  if (getDepth(line)) {
    return
  }

  if (!line.includes('=')) {
    return
  }

  if (line.includes('->')) {
    return
  }

  let [key, value] = line.split('=')
  key = key.trim()
  value = value.trim()
  if (~key.search(/[\s\{\}\(\)\[\]\.,'"]/)) {
    return
  }

  return [key, value]

}

// export
export default (data: iData) => {

  let content: string[] = []

  for (const line of data.main) {

    let [key, value] = pickData(line) || []

    if (!(key && value)) {
      content.push(line)
      continue
    }

    if (value.includes('[')) {
      const list = value
        .replace(/[\[\]]/g, '')
        .split(',')
      for (const i in list) {
        content.push(`${key}[${i}] = ${list[i].trim()}`)
      }
      data.var.push(`${key} = []`)
      continue
    }

    data.var.push(`${key} = ${value}`)

  }

  data.main = content

}