import React, { useState, useEffect } from 'react'
import axios from 'axios'

const Metric = ({ id }) => {
  const [metric, setMetric] = useState([])

  console.log('id::::::::', id)
  useEffect(() => {
    axios.get(`/api/v1/metrics/${id}`, {
      params: {
        include: ['readings']
      }
    })
    .then( resp => {
      // setMetric(resp.data.data)
      console.log(resp)
    })
    .catch( resp => console.log(resp))
  }, [id])

  return (
    <div className='card' key={id}>
      <div></div>
    </div>
  )
}

export default Metric