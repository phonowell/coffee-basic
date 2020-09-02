import { regFn } from './fn'

// interface

import { Block } from '../type'

// function

function main(
  listMain: string[],
  listFn: Block[]
): void {

  if (!(
    listMain
      .join('\n')
      .trim()
  )) return

  regFn(listFn, '$default', '', listMain)
}

// export
export default main