request = require 'request'
cheerio = require 'cheerio'

scrape = (cb) ->

  results = []
  page = "http://www.bbfc.co.uk/releases/latest-decisions?page="
  nonExistentPage = "#{page}999999"

  request.get nonExistentPage, (err, resp, body) ->

    if err
      cb err
      return

    $ = cheerio.load body
    finalPage = $('li.pager-item ').last().text()

    nPending = finalPage
    for i in [1..finalPage]
      do (i) ->
        currentPage = "#{page}#{i}"
        request.get currentPage, (err, resp, body) ->
          --nPending

          if err
            cb err
            return

          data = process body
          results.push d for d in data
          if nPending is 0
            cb null, results

process = (body) ->
   
  insights = []
  $ = cheerio.load body
  strong = $('.recent-decision p strong').filter (i,e) ->
    $(e).text() is "BBFC Insight"
  strong.each (i,e) ->
    insight = $(e).parent().text().replace /^.*\- /g, ''
    insights.push insight

  return insights

module.exports = {scrape}
