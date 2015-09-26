import Foundation

public extension JSON{
  static let emptyObject = JSON.Object(JSONObject())
  static let emptyArray = JSON.Array(JSONArray())
  
  
  var isNull:Bool{
    if case .Null = self{
      return true
    }
    return false
  }

  
  var isNotNull:Bool{
    return !isNull
  }
  
  
  var objectValue:JSONObject?{
    guard case .Object(let object) = self else{
      return nil
    }
    return object
  }
  
  
  var isObject:Bool{
    if case .Object = self{
      return true
    }
    return false
  }
  
  
  var isNotObject:Bool{
    return !isObject
  }
  
  
  var arrayValue:JSONArray?{
    guard case .Array(let array) = self else{
      return nil
    }
    return array
  }
  
  
  var isArray:Bool{
    if case .Array = self{
      return true
    }
    return false
  }
  
  
  var isNotArray:Bool{
    return !isArray
  }
  
  
  var stringValue:Swift.String?{
    guard case .String(let string) = self else{
      return nil
    }
    return string
  }
  
  
  var isString:Bool{
    if case .String = self{
      return true
    }
    return false
  }
  
  
  var isNotString:Bool{
    return !isString
  }
  
  
  var numberValue:NSNumber?{
    guard case .Number(let number) = self else{
      return nil
    }
    return number
  }
  
  
  var isNumber:Bool{
    if case .Number = self{
      return true
    }
    return false
  }
  
  
  var isNotNumber:Bool{
    return !isNumber
  }
  
  
  func val()->Swift.String?{
    guard case .String(let string) = self else{
      return nil
    }
    return string
  }
  
  
  func val()->Int?{
    guard case .Number(let number) = self else{
      return nil
    }
    return number.integerValue
  }
  
  
  func val()->Double?{
    guard case .Number(let number) = self else{
      return nil
    }
    return number.doubleValue
  }
  
  
  func val()->Bool?{
    guard case .Number(let number) = self else{
      return nil
    }
    return number.boolValue
  }
  
  
  func val()->JSONArray?{
    guard case .Array(let array) = self else{
      return nil
    }
    return array
  }
  
  
  func val()->JSONObject?{
    guard case .Object(let object) = self else{
      return nil
    }
    return object
  }
}
