// interface
import { IData } from '../type'

// export
export default (data: IData) => {

  if (!data.raw.startsWith('# use')) return

  data.mode = data.main[0]
    .replace(`# use`, '')
    .trim()
    .split('/')
}