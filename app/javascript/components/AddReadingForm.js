import React from "react";
import { Formik, Form, Field, ErrorMessage } from "formik";
import * as Yup from "yup";
import axios from "axios";

const AddReadingForm = ({ metric, closeModal, setAddedReading }) => {
  const validationSchema = Yup.object().shape({
    time: Yup.date()
      .required("Required")
      .max(new Date(), "Date cannot be in the future"),
    value: Yup.string().required("Required"),
  });

  const submitForm = (values, { setSubmitting }) => {
    axios
      .post(`/api/v1/metrics/${metric.id}/readings`, {
        reading: {
          time: new Date(values.time).toISOString(),
          value: values.value,
        },
      })
      .then((resp) => {
        closeModal();
        setAddedReading(true);
      })
      .catch((resp) => console.log(resp));
    setTimeout(() => {
      setSubmitting(false);
    }, 400);
  };

  return (
    <Formik
      initialValues={{ time: "", value: "" }}
      validationSchema={validationSchema}
      onSubmit={submitForm}
    >
      {({ isSubmitting }) => (
        <div className="flex bg-gray-bg1">
          <div className="w-full m-auto">
            <h1 className="text-2xl font-medium text-primary mb-12 text-center">
              Add data to {metric.name}
            </h1>

            <Form>
              <label htmlFor="time">Time</label>
              <Field
                type="datetime-local"
                name="time"
                className="w-full p-2 text-primary border rounded-md outline-none text-sm transition duration-150 ease-in-out mb-4"
              />
              <ErrorMessage
                name="time"
                component="div"
                className="text-red-500 text-xs italic mb-4"
              />

              <label htmlFor="value">Value</label>
              <Field
                type="number"
                name="value"
                className="w-full p-2 text-primary border rounded-md outline-none text-sm transition duration-150 ease-in-out mb-4"
              />
              <ErrorMessage
                name="value"
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
                  close
                </button>
              </div>
            </Form>
          </div>
        </div>
      )}
    </Formik>
  );
};

export default AddReadingForm;
