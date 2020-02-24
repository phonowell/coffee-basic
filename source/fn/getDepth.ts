// export
export default (line: string) => {
  return Math.floor((line.length - line.trimStart().length) / 2)
}