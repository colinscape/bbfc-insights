#!/usr/bin/env coffee

_ = require 'underscore'

scraper = require './scraper'
analyser = require './analyser'

scraper.scrape (err, data) ->
  results = analyser.analyse data
  sortedInsights = _.sortBy (_.keys results), (k) -> -results[k]
  console.log """
<table>
<thead>
<tr>
<th>Occurrences</th>
<th>Comment</th>
</tr>
</thead>
<tbody>
"""
  console.log "<tr><td>#{results[insight]}</td><td>#{insight}</td></tr>" for insight in sortedInsights
  console.log """
</tbody>
</table>
"""
