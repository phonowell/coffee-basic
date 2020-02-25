// interface
import { iData } from '../type'

// export
export default (data: iData) => {

  if (!(data.main.join('\n').trim())) {
    return
  }

  data.fn.push({
    name: 'default',
    argument: '',
    content: data.main
  })

}