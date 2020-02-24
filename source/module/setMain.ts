// export
export default () => {

  if (!(this.main.join('\n').trim())) {
    return
  }

  this.function.push({
    name: 'default',
    argument: [],
    content: this.main
  })

}