if Meteor.isClient
  Jobs = new Meteor.Collection(null)
  Template.home.rendered = ->
    Jobs.remove({})
    jobs = Meteor.call 'loadList', "", (error,results) ->
      if(error)
       console.log(error)
      else
        console.log(results.data)
        Jobs.insert item for item in results.data

  Template.home.helpers
    job: ->
      Jobs.find()

if Meteor.isServer
  Meteor.methods loadList: (item) ->
    @unblock()
    Meteor.http.call "GET", "http://jobs.github.com/positions.json"
