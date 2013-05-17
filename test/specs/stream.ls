spec     = (require 'brofist')!
{expect} = require 'chai'
Stream   = require '../../lib/stream'

module.exports = spec '{} Stream' (it, spec) ->
  spec 'init :: @stream a => a -> stream a' ->
    it 'Should'
