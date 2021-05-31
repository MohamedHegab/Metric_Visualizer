import React, { useState, useEffect } from 'react'
import axios from 'axios'
import { deserialize } from "deserialize-json-api";

const Metric = ({ id }) => {
  const [metric, setMetric] = useState([])

  useEffect(() => {
    axios.get(`/api/v1/metrics/${id}`, {
      params: {
        include: ['readings']
      }
    })
    .then( resp => {
      setMetric(deserialize(resp.data)?.data)
    })
    .catch( resp => console.log(resp))
  }, [id])

  return (
    <div className='card' key={id}>
      <div>{metric.name}</div>
    </div>
  )
}

export default Metric