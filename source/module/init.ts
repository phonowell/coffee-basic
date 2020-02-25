// interface
import { iData } from '../type'

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
  } as iData

}