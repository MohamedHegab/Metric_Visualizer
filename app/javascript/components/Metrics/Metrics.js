import React, { useState, useEffect, Fragment } from 'react'
import axios from 'axios'
import Metric from './Metric'
import { deserialize } from "deserialize-json-api";

const Metrics = () => {
  const [metrics, setMetrics] = useState([])

  useEffect(() => {
    axios.get('/api/v1/metrics')
    .then( resp => {
      setMetrics(deserialize(resp.data)?.data)
    })
    .catch( resp => console.log(resp))
  }, [metrics.length])

  const list = metrics.map( item => {
    return(<Metric key={item.id} id={item.id} />)
  })

  return (
    <div className=''>
      <div className=''>
        <h1>Metrics</h1>
        <div className=''>All your Metrics.</div>
      </div>
      <div className='grid sm:grid-cols-1 lg:grid-cols-2 gap-4'>
        {list}
      </div>
    </div>
  )
}

export default Metrics