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

  const list = metrics.map( metric => {
    return(<Metric key={metric.id} metric={metric} />)
  })

  return (
    <div className='main-content flex-1 bg-gray-100 pb-24 md:pb-5'>
      <div className="bg-gray-800">
          <div className="bg-gradient-to-r from-blue-900 to-gray-800 p-4 shadow text-2xl text-white">
              <h3 className="font-bold pl-2">Metrics Visualizer</h3>
          </div>
      </div>

      <div className='grid sm:grid-cols-1 lg:grid-cols-2 gap-4 mt-2 mr-2 ml-2'>
        {list}
      </div>
    </div>
  )
}

export default Metrics