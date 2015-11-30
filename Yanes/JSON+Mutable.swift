public extension JSON{
  mutating func append(json:JSON){
    guard case .Array(let array) = self else{
      fatalError("Cannot append to non-array JSON value")
    }
    self = .Array(array + [json])
  }
  
  
  mutating func updateValue(json:JSON, forKey key:JSONKey)->JSON?{
    guard case .Object(var object) = self else{
      fatalError("Cannot associate values with a non-object JSON value")
    }
    let replaced = object.updateValue(json, forKey: key)
    self = .Object(object)
    return replaced
  }
  
  
  mutating func removeValueForKey(key:JSONKey){
    guard case .Object(var object) = self else{
      fatalError("Cannot dissassociate values from a non-object JSON value")
    }
    object.removeValueForKey(key)
    self = .Object(object)
  }
}