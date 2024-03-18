import Book from "./components/Book"
import finnaApi from "./services/finnaApi"
import { useState, useEffect } from 'react'

const BookList = () => {

  const [books, setBooks] = useState([])

  useEffect(() => {
    finnaApi
      .getYanagiharaBooks()
      .then(data => {
        setBooks(data.records)
      })
  }, [])

  return (
    <div>
      <h1>Book List</h1>
      <ul>{books.map(book => <Book key={book.id} book={book}/>)}</ul>
    </div>
  )
}

const App = () => (
    <BookList />
)

export default App
