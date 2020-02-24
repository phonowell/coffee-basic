// export
export default (line: string) => {

  if (!line.includes('#{')) {
    return line
  }

  return line
    .replace(/#{/g, '" . ')
    .replace(/}/g, ' . "')
    .replace(/\.\s*""\s*\./g, '.')
    .replace(/"\s*\.\s*\.\s*"/g, '')

}