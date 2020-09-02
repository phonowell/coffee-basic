// interface
import { ArgumentBuiltIn } from '../type'

// function

export function $beep(): string {
  return 'SoundBeep'
}

export function $click(
  { argument }: ArgumentBuiltIn
): string {
  return argument[0]
    ? `Click % ${argument[0].replace(/:/g, ' ')}`
    : 'Click'
}

export function $exit(
  { output }: ArgumentBuiltIn
): string[] {

  const listResult = ['ExitApp']
  if (output)
    listResult.push(`${output} = 42`)
  return listResult
}

export function $move(
  { argument, output }: ArgumentBuiltIn
): string[] {

  const arg = `${argument[0] || 0}, ${argument[1] || 0}, ${argument[2] || 0}`
  const listResult = [
    `MouseMove ${arg}`
  ]
  if (output)
    listResult.push(`${output} = [${arg}]`)
  return listResult
}

export function $reload(): string {
  return 'Reload'
}

export function $sleep(
  { argument }: ArgumentBuiltIn
): string {
  return `Sleep % ${argument[0]}`
}