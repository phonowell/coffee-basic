// interface

import { ArgumentBuiltIn } from '../type'

// function

export function $setFixed(
  { argument }: ArgumentBuiltIn
): string {

  let isFixed = 'Toggle'
  if (argument[0] === 'true')
    isFixed = 'On'
  else if (argument[0] === 'false')
    isFixed = 'Off'

  return `Winset AlwaysOnTop, ${isFixed}, A`
}