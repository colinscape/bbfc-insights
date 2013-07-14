_ = require 'underscore'

analyse = (data) ->
  for info in data
    simple_insight = info.insight.replace /[^a-z0-9 ]/gi, ''
    simple_insight = simple_insight.replace /[  *]/g, ' '
    words = simple_insight.toLowerCase().split ' '
    words = _.filter words, (w) -> w.length > 0
    info.words = words
  return data

module.exports = {analyse}
