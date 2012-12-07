_ = require 'underscore'

analyse = (data) ->
  info = {}
  for line in data

    content = line.replace /^Contains /g, ''
    content = content.replace ', and ', ' and '
    content = content.replace ' domestic and ', ' domestic threat and '
    content = content.replace /, once/g, ' - once'
    content = content.replace /, twice/g, ' - twice'
    content = content.replace /, some very strong/g, ' - some very strong'
    content = content.replace /\./g, ''
    content = content.toLowerCase()

    cautions = content.split ', '
    for caution in cautions
      finalCautions = caution.split ' and '
      finalCautions2 = []
      for finalCaution in finalCautions
        finalCautions2.push t for t in finalCaution.split ' & '
      for finalCaution in finalCautions2
        if finalCaution.length > 0
          if not info[finalCaution]? then info[finalCaution] = 0
          ++info[finalCaution]
  return info

module.exports = {analyse}
