import Foundation

public extension JSON{
  static let emptyObject = JSON.ObjectValue(JSONObject())
  static let emptyArray = JSON.ArrayValue(JSONArray())
  
  
  var isNull:Bool{
    if case .NullValue = self{
      return true
    }
    return false
  }
  
  
  var objectValue:JSONObject?{
    guard case .ObjectValue(let object) = self else{
      return nil
    }
    return object
  }
  
  
  var isObject:Bool{
    if case .ObjectValue = self{
      return true
    }
    return false
  }
  
  
  var arrayValue:JSONArray?{
    guard case .ArrayValue(let array) = self else{
      return nil
    }
    return array
  }
  
  
  var isArray:Bool{
    if case .ArrayValue = self{
      return true
    }
    return false
  }
  
  
  var stringValue:String?{
    guard case .StringValue(let string) = self else{
      return nil
    }
    return string
  }
  
  
  var isString:Bool{
    if case .StringValue = self{
      return true
    }
    return false
  }
  
  
  var numberValue:NSNumber?{
    guard case .NumberValue(let number) = self else{
      return nil
    }
    return number
  }
  
  
  var isNumber:Bool{
    if case .NumberValue = self{
      return true
    }
    return false
  }
  
  
  var boolValue:Bool?{
    return numberValue?.boolValue
  }
  
  
  var isBool:Bool{
    return isNumber // ಠ_ಠ
  }
}