// interface
import { IArgumentBuiltIn } from '../type'

// export

export function $abs({ argument, output }: IArgumentBuiltIn) {

  if (!output) {
    throw new Error('found no output')
  }

  return `${output} = Abs(${argument[0]})`
}

export function $ceil({ argument, output }: IArgumentBuiltIn) {

  if (!output) {
    throw new Error('found no output')
  }

  return `${output} = Ceil(${argument[0]})`
}

export function $floor({ argument, output }: IArgumentBuiltIn) {
  
  if (!output) {
    throw new Error('found no output')
  }

  return `${output} = Floor(${argument[0]})`
}

export function $round({ argument, output }: IArgumentBuiltIn) {

  if (!output) {
    throw new Error('found no output')
  }

  return `${output} = Round(${argument[0]})`
}