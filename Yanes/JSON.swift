import Foundation

public enum JSON{
  case String(Swift.String)
  case Number(NSNumber)
  case Null
  indirect case Object(JSONObject)
  indirect case Array(JSONArray)
}



public extension JSON{
  init(_ int:Int){
    self = JSON.Number(NSNumber(integer: int))
  }
  
  
  init(_ double:Double){
    self = JSON.Number(NSNumber(double: double))

  }
  
  
  init(_ bool:Bool){
    self = JSON.Number(NSNumber(bool: bool))
  }
  
  
  init(_ number:NSNumber){
    self = JSON.Number(number)
  }
  
  
  init(_ string:Swift.String){
    self = JSON.String(string)
  }
  
  
  init(_ array:JSONArray){
    self = JSON.Array(array)
  }
  
  
  init(_ object:JSONObject){
    self = JSON.Object(object)
  }
  
  
  subscript(key:JSONKey)->JSON?{
    get{
      guard case .Object(let object) = self else{
        return nil
      }
      return object[key]
    }
    set{
      guard case .Object(var object) = self else{
        fatalError("Attempted to mutate non-object value by key.")
      }
      object[key] = newValue
      self = JSON.Object(object)
    }
  }
  
  
  // We shouldn't have to break this into «first» and «rest», but it works around a bug where a single variadic argument won't infer type correctly and thus won't pick up subscript's integer- and string-literal convertable code.
  subscript(first:JSONIndex, rest:JSONIndex...)->JSON?{
    get{
      return jsonForSubscripts([first]+rest)
    }
  }
  
  
  //The variadic version is great for literals, but sometimes we want to pass a path as a variable. Swift doesn't have a way to «apply» arguments yet, so using an array is our only choice.
  subscript(subscripts:[JSONIndex])->JSON?{
    get{
      return jsonForSubscripts(subscripts)
    }
  }
}


private extension JSON{
  func jsonForSubscripts(subscripts:[JSONIndex])->JSON?{
    return subscripts.reduce(self){ json, sub in
      return json?.valueForSubscript(sub)
    }
  }
  
  
  func valueForSubscript(element:JSONIndex)->JSON?{
    //These doesn't loop inifinitely because «index» is a constant not a literal. That means it doesn't get converted to a JSONIndex and thus gets handled by the collection code.    
    switch element{
    case .Key(let key) where isObject:
      return self[key]
    case .Index(let index) where isNotObject && isNotNull:
      return self[index]
    default:
      return nil
    }
  }
}