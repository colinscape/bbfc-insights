#!/usr/bin/env coffee

_ = require 'underscore'

Firebase = require 'firebase'
myRootRef = new Firebase 'https://bbfc.firebaseIO.com/'
wordsRef = myRootRef.child 'words'

scraper = require './scraper'
analyser = require './analyser'

scraper.scrape (err, data) ->
  results = analyser.analyse data
  for result in results

    console.log "Processing #{result.title}"

    for word in result.words
      wordRef = wordsRef.child word
      newRef = wordRef.child result.id
      newRef.set
        name: result.title
        insight: result.insight

  process.exit()
