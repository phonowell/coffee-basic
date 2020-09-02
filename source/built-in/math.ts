// interface

import { ArgumentBuiltIn } from '../type'

// function

export function $abs(
  { argument, output }: ArgumentBuiltIn
): string {

  if (!output) throw new Error('found no output')
  return `${output} = Abs(${argument[0]})`
}

export function $ceil(
  { argument, output }: ArgumentBuiltIn
): string {

  if (!output) throw new Error('found no output')
  return `${output} = Ceil(${argument[0]})`
}

export function $floor(
  { argument, output }: ArgumentBuiltIn
): string {

  if (!output) throw new Error('found no output')
  return `${output} = Floor(${argument[0]})`
}

export function $round(
  { argument, output }: ArgumentBuiltIn
): string {

  if (!output) throw new Error('found no output')
  return `${output} = Round(${argument[0]})`
}