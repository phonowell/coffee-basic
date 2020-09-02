import $ from 'fire-keeper'

// function

async function main_(): Promise<void> {
  $.info([0, 1, 2, 3, 4].map(n => n * 2))
}

// export
export default main_