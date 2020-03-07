import formatKey from '../fn/formatKey'

// interface
import { iArgumentBuiltIn } from '../type'

// export
export default ({ argument, output }: iArgumentBuiltIn) => {

  const key = argument[0]
    .replace(/['"]/g, '')

  return [
    `GetKeyState __value__, ${formatKey(key)}`,
    `${output} = __value__ == \"D\"`
  ]

}