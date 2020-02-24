// export
export default (input: string) => {

  return input
    .toLowerCase()
    .replace(/['"]/g, '')
    .replace(/\-/g, '')
    // ---
    .replace(/equal/g, '=')
    .replace(/minus/g, '-')
    .replace(/num/g, 'numpad')
    .replace(/padpad/g, 'pad')
    .replace(/pagedown/g, 'pgdn')
    .replace(/pageup/g, 'pgup')
    .replace(/plus/g, '+')
    // --
    .replace(/:/g, ' ')

}