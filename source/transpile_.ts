import buildIn from './build-in'
import call from './call'
import format from './format'
import getBind from './getBind'
import getFunction from './getFunction'
import getGlobal from './getGlobal'
import getMode from './getMode'
import include_ from './include_'
import render from './render'
import replaceFor from './replaceFor'
import replaceIf from './replaceIf'
import replaceLoop from './replaceLoop'
import setFoot from './setFoot'
import setHead from './setHead'
import setMain from './setMain'
import validate from './validate'

// interface

interface iOption {
  bare?: boolean
}

// function

class Content {

  raw: string
  option: iOption
  bind: string[]
  foot: string[]
  function: string[]
  global: string[]
  head: string[]
  mode: string[]

  constructor(raw: string, option: iOption) {

    this.raw = raw
    this.option = option

    this.bind = []
    this.foot = []
    this.function = []
    this.global = []
    this.head = []
    this.mode = []

    return this

  }

  // ---

  i(input: string) {
    console.log(input)
    return input
  }

  // ---

  buildIn = buildIn
  call = call
  format = format
  getBind = getBind
  getFunction = getFunction
  getGlobal = getGlobal
  getMode = getMode
  include_ = include_
  render = render
  replaceFor = replaceFor
  replaceIf = replaceIf
  replaceLoop = replaceLoop
  setFoot = setFoot
  setHead = setHead
  setMain = setMain
  validate = validate

  // ---

  async execute_() {

    await this.include_()

    if (!this.validate()) {
      return ''
    }

    this.getMode()
    this.format()

    this.getGlobal()
    this.getFunction()
    this.getBind()

    this.setMain()
    if (!this.option.bare) {
      this.setHead()
      this.setFoot()
    }

    this.replaceIf()
    this.replaceFor()
    this.replaceLoop()

    this.call()
    this.buildIn()

    return this.render()

  }

}

// export
export default async (source: string, option: iOption = {}) => {
  return new Content(source, option).execute_()
}