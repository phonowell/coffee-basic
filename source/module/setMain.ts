// interface
import { IData } from '../type'

// export
export default (data: IData) => {

  if (!(data.main.join('\n').trim())) {
    return
  }

  data.fn.push({
    name: 'default',
    argument: '',
    content: data.main
  })

}