import { trim } from '../module/fn'

// interface
import { iArgumentBuiltIn } from '../type'

// export

export function $beep() {
  return 'SoundBeep'
}

export function $click({ argument }: iArgumentBuiltIn) {

  if (!argument[0]) {
    return 'Click'
  } else {
    return `Click % ${argument[0].replace(/:/g, ' ')}`
  }

}

export function $exit() {
  return 'ExitApp'
}

export function $move({ argument }: iArgumentBuiltIn) {
  return `MouseMove ${argument[0] || 0}, ${argument[1] || 0}, ${argument[2] || 0}`
}

export function $open({ argument }: iArgumentBuiltIn) {
  return `Run ${trim(argument[0])}`
}

export function $reload() {
  return 'Reload'
}

export function $sleep({ argument }: iArgumentBuiltIn) {
  return `Sleep % ${argument[0]}`
}