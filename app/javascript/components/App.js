import React from "react";
import { Route, Switch } from "react-router-dom";
import Metrics from "./Metrics";
import "tailwindcss/tailwind.css";

const App = () => {
  return (
    <Switch>
      <Route exact path="/" component={Metrics} />
    </Switch>
  );
};

export default App;
