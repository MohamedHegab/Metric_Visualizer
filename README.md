# Metric Visualizer

![https://i.ibb.co/7NT2GWK/metric-visualizer-image.png](https://i.ibb.co/7NT2GWK/metric-visualizer-image.png)

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

![https://i.ibb.co/6BhxbW6/metric-visualizer-be.png](https://i.ibb.co/6BhxbW6/metric-visualizer-be.png)

The relation between components in React

![https://i.ibb.co/kSf8wwh/metric-visualizer-fd.png](https://i.ibb.co/kSf8wwh/metric-visualizer-fd.png)

## **Future Enhancements**

- Expose add reading api so that we can add reading automatically from multiple sources