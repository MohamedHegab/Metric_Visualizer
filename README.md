# Metric Visualizer

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f63e59c5-873f-4d42-b91f-06a180810a65/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f63e59c5-873f-4d42-b91f-06a180810a65/Untitled.png)

## **Description**

Enable you to view your data in nice graphs with the ability to add another metric or add data to any metric.

Can filter each graph with the time range and the average / period data.

## **Prerequisites**

- Ruby 2.7.2 installed on the system
- Yarn Installed on the system

## **How To Start**

1. `bundle install`
2. `rails db:create && rails db:migrate && rails db:seed`
3. `yarn install`
4. `rails s`

## **About the Project**

Backend ruby on rails application tested with RSpec.

These are the relation between models in the backend.

![https://ibb.co/bJhZLKp](https://ibb.co/bJhZLKp)

The relation between components in React

![https://ibb.co/RDm0ssC](https://ibb.co/RDm0ssC)

## **Future Enhancements**

- Expose add reading api so that we can add reading automatically from multiple sources