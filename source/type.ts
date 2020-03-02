export interface iBlock {
  argument: string
  content: string[]
  name: string
}

export interface iData {
  event: iBlock[]
  fn: iBlock[]
  foot: string[]
  head: string[]
  main: string[]
  mode: string[]
  raw: string
  var: string[]
}

export interface iOption {
  bare?: boolean
  path?: string
}