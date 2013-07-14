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
   
  results = []
  $ = cheerio.load body
  decisions = $('.recent-decision')

  decisions.each (i,e) ->
    title = $('h3', $(e)).text()
    id = $('h3 a', $(e)).attr('href')
    insights = $('p strong', $(e)).filter (i2,e2) ->
      $(e2).text() is "BBFC Insight"
    insights.each (i,e) ->
      insight = $(e).parent().text().replace /^.*\- /g, ''
      result =
        id: id
        title: title
        insight: insight
      results.push result
  return results

module.exports = {scrape}
