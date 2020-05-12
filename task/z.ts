import $ from '../lib/fire-keeper'

// export
export default async () =>
  $.info([0, 1, 2, 3, 4].map(n => n * 2))