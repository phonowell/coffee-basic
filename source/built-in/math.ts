// interface
import { iArgumentBuiltIn } from '../type'

// export

export function $abs({ argument, output }: iArgumentBuiltIn) {
  return `${output} = Abs(${argument[0]})`
}

export function $ceil({ argument, output }: iArgumentBuiltIn) {
  return `${output} = Ceil(${argument[0]})`
}

export function $floor({ argument, output }: iArgumentBuiltIn) {
  return `${output} = Floor(${argument[0]})`
}

export function $round({ argument, output }: iArgumentBuiltIn) {
  return `${output} = Round(${argument[0]})`
}