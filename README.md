# Task description

Given signal stations location(X,Y) and their range, determine if quadrocopter can fly from Starting point to finish assuming it can only fly in signal station range

## Solution description

A graph can be constructed using base stations and their ranges. Assuming that base stations are nodes of graph - they will be a route(edge) if their signals overlap.
Once we have the graph constructed its just a matter of saying START and FINISH are on the same graph.

# Setup

## Install dependencies
`bundle install`


## To run the app
`ruby main.rb`

# Specs
`bundle exec rspec`
