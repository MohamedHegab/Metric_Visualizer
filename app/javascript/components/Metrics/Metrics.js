import React, { useState, useEffect, Fragment } from 'react'
import axios from 'axios'
import Metric from './Metric'

const Metrics = () => {
  const [metrics, setMetrics] = useState([])

  useEffect(() => {
    axios.get('/api/v1/metrics')
    .then( resp => {
      setMetrics(resp.data.data)
    })
    .catch( resp => console.log(resp))
  }, [metrics.length])


  const list = metrics.map( item => {
    return(<Metric key={item.id} id={item.id} />)
  })

  return (
    <div className='home'>
      <div className='header'>
        <h1>Metrics</h1>
        <div className='subheader'>All your Metrics.</div>
      </div>
      <div className='grid'>
        {list}
      </div>
    </div>
  )
}

export default Metrics