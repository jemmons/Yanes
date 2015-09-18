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

  
  var isNotNull:Bool{
    return !isNull
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
  
  
  var isNotObject:Bool{
    return !isObject
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
  
  
  var isNotArray:Bool{
    return !isArray
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
  
  
  var isNotString:Bool{
    return !isString
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
  
  
  var isNotNumber:Bool{
    return !isNumber
  }
  
  
  func val()->String?{
    guard case .StringValue(let string) = self else{
      return nil
    }
    return string
  }
  
  
  func val()->Int?{
    guard case .NumberValue(let number) = self else{
      return nil
    }
    return number.integerValue
  }
  
  
  func val()->Double?{
    guard case .NumberValue(let number) = self else{
      return nil
    }
    return number.doubleValue
  }
  
  
  func val()->Bool?{
    guard case .NumberValue(let number) = self else{
      return nil
    }
    return number.boolValue
  }
  
  
  func val()->JSONArray?{
    guard case .ArrayValue(let array) = self else{
      return nil
    }
    return array
  }
  
  
  func val()->JSONObject?{
    guard case .ObjectValue(let object) = self else{
      return nil
    }
    return object
  }
}
