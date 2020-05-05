import { regFn } from '../module/fn'

// interface
import { IData } from '../type'

// export
export default (data: IData) => {
  if (!(data.main.join('\n').trim())) return
  regFn(data, '$default', '', data.main)
}