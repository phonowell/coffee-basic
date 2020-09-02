// interface

import { ArgumentBuiltIn } from '../type'

// function

export function $trim(
  { argument }: ArgumentBuiltIn
): string {
  return `Trim ${argument[0]}`
}

export function $trimEnd(
  { argument }: ArgumentBuiltIn
): string {
  return `RTrim ${argument[0]}`
}

export function $trimStart(
  { argument }: ArgumentBuiltIn
): string {
  return `LTrim ${argument[0]}`
}