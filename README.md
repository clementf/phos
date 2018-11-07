# Phos

Phos provides an interface to control a strip of leds connected to a Raspberry pi, typically a NeoPixels setup as seen [here](https://dordnung.de/raspberrypi-ledstrip/ws2812).

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- Ruby (version specified in .ruby-version)
- Bundler (`gem install bundler`)
- Python
- NodeJS


### Installing

- Clone the repo

```
git clone https://github.com/clementf/phos
```

- Install ruby dependencies

```
bundle install
```

- Install javascript dependencies

`yarn` or `npm install`


## Run
Build the frontend dependencies with `npm run build` or `yarn build`.

Get the app running with: `procodile start --dev`.

## Tests

The test framework is [Rspec](http://rspec.info/). Although test coverage isn't good yet, tests run using `rspec`


## Deployment

The python scripts that talk to the leds have to run as `root` on the raspberry pi.

I recommend using a toold like [procodile](https://github.com/adamcooke/procodile) to run the app in production. Procodile uses a `Procfile`, and is comaprable to [foreman](https://github.com/ddollar/foreman).

To start the app, run `sudo procodile start`.

## Built With

* [Sinatra](http://sinatrarb.com/) - Ruby web framework
* [React](https://reactjs.org/) - Frontend


## Acknowledgments

* [Sinatra react starter](https://github.com/alanbsmith/react-sinatra-example)
* [Building the hardware part](https://dordnung.de/raspberrypi-ledstrip/ws2812)
* [C (not only) library to control the led strip](https://github.com/jgarff/rpi_ws281x)

