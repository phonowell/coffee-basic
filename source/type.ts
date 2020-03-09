export interface IBlock {
  argument: string
  content: string[]
  name: string
}

export interface IData {
  event: IBlock[]
  fn: IBlock[]
  foot: string[]
  head: string[]
  main: string[]
  mode: string[]
  raw: string
  var: string[]
}

export interface IOption {
  bare?: boolean
  path?: string
}

export interface IArgumentBuiltIn {
  argument: string[]
  output: string
}