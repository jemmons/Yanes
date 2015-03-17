import Foundation
import Result

public enum JSONCollection{
  case ObjectValue(JSONObject)
  case ArrayValue(JSONArray)
}



public extension JSONCollection{
  
  init?(string:String){
    var noOp:NSError?
    self.init(string:string, error:&noOp)
  }
  
  
  init?(string:String, inout error outError:NSError?){
    switch self.dynamicType.jsonCollectionFromString(string){
    case .Error(let error):
      outError = error
      return nil
    case .Value(let boxed):
      self = boxed.unbox
    }
  }
  
  
  var objectValue:JSONObject?{
    switch self{
    case .ObjectValue(let object):
      return object
    default:
      return Optional<JSONObject>()
    }
  }
  
  
  var isObject:Bool{
    return objectValue != nil
  }
  
  
  var arrayValue:JSONArray?{
    switch self{
    case .ArrayValue(let array):
      return array
    default:
      return Optional<JSONArray>()
    }
  }
  
  
  var isArray:Bool{
    return arrayValue != nil
  }
}



private extension JSONCollection{
  static func jsonCollectionFromString(rawJSON:String)->Result<JSONCollection>{
    return jsonObjectFromString(rawJSON).flatMap{ self.jsonCollectionFromJSONObject($0) }
  }
  
  
  static func jsonObjectFromString(rawJSON:String)->Result<AnyObject>{
    let data = rawJSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)!
    var error:NSError?
    var object:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:&error)
    if let someError = error{
      return .Error(someError)
    } else{
      return Result(object!)
    }
  }
  
  
  static func jsonCollectionFromJSONObject(jsonObject:AnyObject)->Result<JSONCollection>{
    switch jsonObject{
    case let array as NSArray:
      return jsonCollectionFromArray(array)
    case let dictionary as NSDictionary:
      return jsonCollectionFromDictionary(dictionary)
    default:
      return .Error(NSError.YanesInvalidContainerObjectError())
    }
  }
  
  
  static func jsonCollectionFromArray(array:NSArray)->Result<JSONCollection>{
    var jsonArray = JSONArray()
    for element in array{
      switch element{
      case let string as String:
        jsonArray.append(JSONValue(string))
      case let number as NSNumber:
        jsonArray.append(JSONValue(number))
      case let array as NSArray:
        switch jsonCollectionFromArray(array){
        case .Error(let error):
          return .Error(error)
        case .Value(let boxed):
          jsonArray.append(JSONValue(boxed.unbox))
        }
      case let dictionary as NSDictionary:
        switch jsonCollectionFromDictionary(dictionary){
        case .Error(let error):
          return .Error(error)
        case .Value(let boxed):
          jsonArray.append(JSONValue(boxed.unbox))        
        }
      default:
        return .Error(NSError.YanesInvalidJSONValueError())
      }
    }
    return Result(.ArrayValue(jsonArray))
  }

  
  static func jsonCollectionFromDictionary(dictionary:NSDictionary)->Result<JSONCollection>{
    var jsonObject = JSONObject()
    for (anyKey, anyValue) in dictionary{
      
      if let key = anyKey as? String{
        switch anyValue{
        case let string as String:
          jsonObject[key] = JSONValue(string)
        case let number as NSNumber:
          jsonObject[key] = JSONValue(number)
        case let array as NSArray:
          switch jsonCollectionFromArray(array){
          case .Error(let error):
            return .Error(error)
          case .Value(let boxed):
            jsonObject[key] = JSONValue(boxed.unbox)
          }
        case let dictionary as NSDictionary:
          switch jsonCollectionFromDictionary(dictionary){
          case .Error(let error):
            return .Error(error)
          case .Value(let boxed):
            jsonObject[key] = JSONValue(boxed.unbox)
          }
        default:
          return .Error(NSError.YanesInvalidJSONValueError())
        }
      } else{
        return .Error(NSError.YanesInvalidJSONKeyError())
      }
    }
    return Result(.ObjectValue(jsonObject))
  }
}



extension JSONCollection : Printable{
  public var description:String{
    switch self{
    case .ObjectValue(let object):
      return object.description
    case .ArrayValue(let array):
      return array.description
    }
  }
}
