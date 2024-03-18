const baseUrl = "https://api.finna.fi/v1/search"

const getYanagiharaBooks = () => {
  return fetch(`${baseUrl}?lookfor=yanagihara`)
    .then(response => response.json())
}

export default { getYanagiharaBooks }