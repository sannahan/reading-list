import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'

const Greeting = (props) => (
    <div>
      <p>Hello {props.name}!</p>
    </div>
)

const App = () => (
    <Greeting name='world' />
)

export default App
