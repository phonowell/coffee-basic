import formatKey from '../fn/formatKey'

// export
export default (
  { argument, output }: { argument: string[], output: string }
) => {

  const key = argument[0]
    .replace(/['"]/g, '')

  return [
    `GetKeyState __value__, ${formatKey(key)}`,
    `${output} = __value__ == \"D\"`
  ]

}