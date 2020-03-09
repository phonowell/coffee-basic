// interface
import { IArgumentBuiltIn } from '../type'

// export

export function $abs({ argument, output }: IArgumentBuiltIn) {
  return `${output} = Abs(${argument[0]})`
}

export function $ceil({ argument, output }: IArgumentBuiltIn) {
  return `${output} = Ceil(${argument[0]})`
}

export function $floor({ argument, output }: IArgumentBuiltIn) {
  return `${output} = Floor(${argument[0]})`
}

export function $round({ argument, output }: IArgumentBuiltIn) {
  return `${output} = Round(${argument[0]})`
}