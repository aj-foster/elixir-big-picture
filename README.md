# Elixir: The Big Picture

This repository contains a demonstration app for the Pluralsight course [Elixir: The Big Picture](https://www.pluralsight.com/courses/elixir-big-picture).

The purpose of this demonstration is to show the power of Elixir's concurrency model by creating hundreds or thousands of running processes.
Each process reports itself as a dot on the screen, which moves as the process sends and receives messages.

## Usage

To get up and running:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Then, visit [`localhost:4000`](http://localhost:4000) to see the demonstration.
