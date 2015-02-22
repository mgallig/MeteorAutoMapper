
#http://jsfiddle.net/c463acyu/2/
#Add an arbitrary-depth value to the object at 'graph'
#And store the value passed by 'value'
AddObjectToGraph = (graph,full_name,value) ->
  names = full_name.split '.'    
  currentObj = graph
  for name in names  
      lastObj = currentObj
      currentObj = currentObj[name] ?= {}    

  lastObj[name] = value

  console.log(graph)

#Client bit down here, look for things that start with a prefix and use them to map to the graph

if Meteor.isClient
  Template.pathfinder_character.events 'submit .update-character': (event) ->    
    props = {}
    for element in event.target
      if element.tagName == "INPUT" 
        name = "" + element.name
        console.log "Name:" + name + "StartsWith " + name.startsWith
        if name.startsWith "sheetProperties"        
          AddObjectToGraph(props,element.name,element.value)
    console.log props
    Characters.update { _id: this._id }, { $set: sheetProperties: props.sheetProperties }, multi: false

    #Characters.update(this._id, {$set: {checked: ! this.checked}});
    false
    
    
    
    
    #Helper to fetch the values!
    Template.pathfinder_character.helpers 
      sheetProperties: (key) ->      
        this.sheetProperties[key]
      
