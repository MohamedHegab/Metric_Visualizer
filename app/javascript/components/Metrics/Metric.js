import React, { useState, useEffect } from 'react'
import axios from 'axios'
import { deserialize } from "deserialize-json-api";
import Chart from './Chart';

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
    <div key={id}>
      <div>{metric.name}</div>
      <div style={{ height: 350 }} className="App">
        <Chart
          data={[
            {
              id: "LineOne",
              data: metric?.readings?.map((reading, i) => ({ x: reading?.time, y: reading?.value }))
            }
          ]}
        />
      </div>
    </div>
  )
}

export default Metric