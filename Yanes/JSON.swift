import Foundation

public enum JSON{
  case StringValue(String)
  case NumberValue(NSNumber)
  case NullValue
  indirect case ObjectValue(JSONObject)
  indirect case ArrayValue(JSONArray)
}



public extension JSON{
  init(number:NSNumber){
    self = JSON.NumberValue(number)
  }
  
  
  init(string:String){
    self = JSON.StringValue(string)
  }


  init(array:JSONArray){
    self = JSON.ArrayValue(array)
  }


  init(object:JSONObject){
    self = JSON.ObjectValue(object)
  }
  
  
  // We shouldn't have to break this into «first» and «rest», but it works around a bug where a single variadic argument won't infer type correctly and thus won't pick up subscript's integer- and string-literal convertable code.
  subscript(first:JSONSubscript, rest:JSONSubscript...)->JSON?{
    get{
      return jsonForSubscripts([first]+rest)
    }
  }
  
  
  //The variadic version is great for literals, but sometimes we want to pass a path as a variable. Swift doesn't have a way to «apply» arguments yet, so using an array is our only choice.
  subscript(subscripts:[JSONSubscript])->JSON?{
    get{
      return jsonForSubscripts(subscripts)
    }
  }
}


private extension JSON{
  func jsonForSubscripts(subscripts:[JSONSubscript])->JSON?{
    return subscripts.reduce(self){ json, sub in
      return json?.valueForSubscript(sub)
    }
  }
  
  
  func valueForSubscript(element:JSONSubscript)->JSON?{
    switch element{
    case .Key(let key) where isObject:
      return objectValue![key]
    case .Index(let index) where isNotObject && isNotNull:
      return self[index] //This doesn't loop inifinitely because «index» is a constant not a literal. That means it doesn't get converted to a JSONSubscript and thus gets handled by the collection code.
    default:
      return nil
    }
  }
}