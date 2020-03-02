import getDepth from '../fn/getDepth'

// interface
import { iData } from '../type'

// function

function validate(line: string) {

  if (getDepth(line)) {
    return
  }

  if (!line.includes('=')) {
    return
  }

  if (line.includes('->')) {
    return
  }

  const key = line.split('=')[0].trim()
  if (~key.search(/[\s\{\}\(\)\[\]\.,'"]/)) {
    return
  }

  return true

}

// export
export default (data: iData) => {

  let content: string[] = []

  for (const line of data.main) {

    if (!validate(line)) {
      content.push(line)
      continue
    }

    data.var.push(line)

  }

  data.main = content

}