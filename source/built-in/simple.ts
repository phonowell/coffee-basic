// interface
import { IArgumentBuiltIn, IData } from '../type'

// export

export function $beep() {
  return 'SoundBeep'
}

export function $click({ argument }: IArgumentBuiltIn) {
  return argument[0]
    ? `Click % ${argument[0].replace(/:/g, ' ')}`
    : 'Click'
}

export function $exit({ output }: IArgumentBuiltIn, data: IData) {
  const result = ['ExitApp']
  if (output) {
    result.push(`${output} = 42`)
  }
  return result
}

export function $move({ argument, output }: IArgumentBuiltIn, data: IData) {
  const arg = `${argument[0] || 0}, ${argument[1] || 0}, ${argument[2] || 0}`
  const result = [
    `MouseMove ${arg}`
  ]
  if (output) {
    result.push(`${output} = [${arg}]`)
  }
  return result
}

export function $reload() {
  return 'Reload'
}

export function $sleep({ argument }: IArgumentBuiltIn) {
  return `Sleep % ${argument[0]}`
}