import { trim } from '../module/fn'

// interface
import { IArgumentBuiltIn } from '../type'

// export

export function $beep() {
  return 'SoundBeep'
}

export function $click({ argument }: IArgumentBuiltIn) {

  if (!argument[0]) {
    return 'Click'
  } else {
    return `Click % ${argument[0].replace(/:/g, ' ')}`
  }

}

export function $exit() {
  return 'ExitApp'
}

export function $move({ argument }: IArgumentBuiltIn) {
  return `MouseMove ${argument[0] || 0}, ${argument[1] || 0}, ${argument[2] || 0}`
}

export function $open({ argument }: IArgumentBuiltIn) {
  return `Run ${trim(argument[0])}`
}

export function $reload() {
  return 'Reload'
}

export function $sleep({ argument }: IArgumentBuiltIn) {
  return `Sleep % ${argument[0]}`
}