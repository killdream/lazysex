brofist = require 'brofist'
tap = require 'brofist-tap'
specs = require './specs'

(brofist.run specs, tap!).otherwise -> process?.exit 1
