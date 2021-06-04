import React, { useState, useEffect, Fragment } from "react";
import axios from "axios";
import Metric from "./Metric";
import AddMetricForm from "./AddMetricForm";
import { deserialize } from "deserialize-json-api";
import { ModalProvider } from "react-simple-hook-modal";
import { Modal, useModal, ModalTransition } from "react-simple-hook-modal";

const Metrics = () => {
  const [metrics, setMetrics] = useState([]);
  const { isModalOpen, openModal, closeModal } = useModal();
  const [addedMetric, setAddedMetric] = useState(false);

  useEffect(() => {
    axios
      .get("/api/v1/metrics")
      .then((resp) => {
        setMetrics(deserialize(resp.data)?.data);
        setAddedMetric(false)
      })
      .catch((resp) => console.log(resp));
  }, [addedMetric]);

  const list = metrics.map((metric) => {
    return <Metric key={metric.id} metric={metric} />;
  });

  return (
    <ModalProvider>
      <Modal
        id="any-unique-identifier"
        isOpen={isModalOpen}
        transition={ModalTransition.BOTTOM_UP}
        modalClassName="min-h-0"
      >
        <AddMetricForm
          closeModal={closeModal}
          setAddedMetric={setAddedMetric}
        />
      </Modal>
      <div className="main-content flex-1 bg-gray-100 pb-24 md:pb-5">
        <div className="bg-gray-800">
          <div className="bg-gradient-to-r from-blue-900 to-gray-800 p-4 shadow text-2xl text-white flex justify-between">
            <h3 className="font-bold pl-2">Metrics Visualizer</h3>
            <button
              className="bg-blue-500 hover:bg-blue-700 text-white font-bold px-4 rounded-full cursor-pointer"
              onClick={openModal}
            >
              Add Metric
            </button>
          </div>
        </div>

        <div className="grid sm:grid-cols-1 lg:grid-cols-2 gap-4 mt-2 mr-2 ml-2">
          {list}
        </div>
      </div>
    </ModalProvider>
  );
};

export default Metrics;
