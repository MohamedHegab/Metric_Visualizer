import React from 'react'
import { Route, Switch } from 'react-router-dom'
import Metrics from './Metrics/Metrics'
import Metric from './Metric/Metric'
import "tailwindcss/tailwind.css"

const App = () => {
  return (
    <Switch>
      <Route exact path='/' component={Metrics} />
      <Route exact path='/metrics/:id' component={Metric} />
    </Switch>
  )
}

export default App