import React, { useState, useEffect, useCallback } from "react";
import axios from "axios";
import { deserialize } from "deserialize-json-api";
import Chart from "./Chart";
import AddReadingForm from "./AddReadingForm";
import { Modal, useModal, ModalTransition } from "react-simple-hook-modal";
import LoadingSpinner from "./LoadingSpinner";

const Metric = ({ metric }) => {
  const [readings, setReadings] = useState([]);
  const [timeRange, setTimeRange] = useState("1_days");
  const [period, setPeriod] = useState("minute");
  const [addedReading, setAddedReading] = useState(false);
  const [loading, setLoading] = useState(false);
  const { isModalOpen, openModal, closeModal } = useModal();

  useEffect(() => {
    setLoading(true);
    axios
      .get(`/api/v1/metrics/${metric.id}/readings`, {
        params: {
          period,
          time_range: timeRange,
        },
      })
      .then((resp) => {
        setReadings(deserialize(resp.data)?.data);
        setAddedReading(false);
      })
      .finally(() => {
        setLoading(false);
      })
      .catch((resp) => console.log(resp));
  }, [period, timeRange, addedReading]);

  const handleTimeRangeChange = (e) => {
    setTimeRange(e.target.value);
  };

  const handlePeriodChange = (e) => {
    setPeriod(e.target.value);
  };

  return (
    <div
      key={metric.id}
      className="bg-white border-transparent rounded-lg shadow-xl"
    >
      {
        <Modal
          id="any-unique-identifier"
          isOpen={isModalOpen}
          transition={ModalTransition.BOTTOM_UP}
          modalClassName="min-h-0"
        >
          <AddReadingForm
            metric={metric}
            closeModal={closeModal}
            setAddedReading={setAddedReading}
          />
        </Modal>
      }
      <div className="bg-gradient-to-b from-gray-300 to-gray-100 text-gray-800 border-b-2 border-gray-300 rounded-tl-lg rounded-tr-lg p-2 flex flex-row justify-between">
        <div className="font-bold uppercase text-gray-600">{metric.name}</div>
        <button
          className="bg-blue-500 hover:bg-blue-700 text-white font-bold px-4 rounded-full cursor-pointer"
          onClick={openModal}
        >
          Add data
        </button>
      </div>

      <div className="border-bottom flex flex-row justify-between">
        <div className="flex flex-col ml-2">
          <div>Time range</div>
          <select value={timeRange} onChange={handleTimeRangeChange}>
            <option value="1_hours">Last 1 hour</option>
            <option value="6_hours">Last 6 hours</option>
            <option value="1_days">Last 1 day</option>
            <option value="3_days">Last 3 days</option>
            <option value="1_months">Last 1 month</option>
          </select>
        </div>
        <div className="flex flex-col ml-2">
          <div>Average / Period</div>
          <select value={period} onChange={handlePeriodChange}>
            <option value="minute">1 Minute</option>
            <option value="hour">1 Hour</option>
            <option value="day">1 Day</option>
          </select>
        </div>
      </div>

      <div style={{ height: 350 }} className="App">
        {loading && <LoadingSpinner />}

        {readings.length > 0 && !loading && (
          <Chart
            data={[
              {
                id: "LineOne",
                data: readings?.map((reading, i) => ({
                  x: reading?.time,
                  y: reading?.value,
                })),
              },
            ]}
          />
        )}

        {readings.length === 0 && !loading && (
          <div className="text-center">No data found for this time range.</div>
        )}
      </div>
    </div>
  );
};

export default Metric;
