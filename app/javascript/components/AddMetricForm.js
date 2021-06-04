import React from "react";
import { Formik, Form, Field, ErrorMessage } from "formik";
import * as Yup from "yup";
import axios from "axios";

const AddMetricForm = ({ closeModal, setAddedMetric }) => {
  const validationSchema = Yup.object().shape({
    name: Yup.string().required("Required"),
  });

  const submitForm = (values, { setSubmitting }) => {
    axios
      .post(`/api/v1/metrics`, {
        metric: { ...values },
      })
      .then((resp) => {
        closeModal();
        setAddedMetric(true);
      })
      .catch((resp) => console.log(resp));
    setTimeout(() => {
      setSubmitting(false);
    }, 400);
  };

  return (
    <Formik
      initialValues={{ name: "" }}
      validationSchema={validationSchema}
      onSubmit={submitForm}
    >
      {({ isSubmitting }) => (
        <div className="flex bg-gray-bg1">
          <div className="w-full m-auto">
            <h1 className="text-2xl font-medium text-primary mb-12 text-center">
              Add new metric
            </h1>

            <Form>
              <label htmlFor="name">Name</label>
              <Field
                type="text"
                name="name"
                className="w-full p-2 text-primary border rounded-md outline-none text-sm transition duration-150 ease-in-out mb-4"
              />
              <ErrorMessage
                name="name"
                component="div"
                className="text-red-500 text-xs italic mb-4"
              />

              <div className="flex flex-row">
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="bg-blue-500 hover:bg-blue-700 text-white font-bold px-4 rounded-full cursor-pointer"
                >
                  Submit
                </button>
                <button
                  type="button"
                  className="text-blue border font-bold px-4 rounded-full cursor-pointer"
                  onClick={() => closeModal()}
                >
                  Close
                </button>
              </div>
            </Form>
          </div>
        </div>
      )}
    </Formik>
  );
};

export default AddMetricForm;
