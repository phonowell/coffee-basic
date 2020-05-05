// interface
import { IData } from '../type'

// export
export default (content: string) => {

  return {
    raw: content,
    // ---
    event: [], // event
    fn: [], // function
    foot: [],
    head: [],
    mode: [],
    var: [] // global variable
  } as IData
}