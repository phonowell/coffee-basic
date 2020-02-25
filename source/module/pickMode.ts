// interface
import { iData } from '../type'

// export
export default (data: iData) => {

  if (!data.raw.startsWith('# use')) {
    return
  }

  data.mode = data.main[0]
    .replace(`# use`, '')
    .trim()
    .split('/')

}