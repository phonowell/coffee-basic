// export
export default (input: string) => {

  if (!["'", '"'].includes(input[0])) {
    return input
  }

  return input.slice(1, (input.length - 1))

}