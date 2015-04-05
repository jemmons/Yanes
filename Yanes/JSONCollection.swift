import Foundation
import Result
import GroundFloor

public enum JSONCollection{
  case ObjectValue(JSONObject)
  case ArrayValue(JSONArray)
}



public extension JSONCollection{
  //MARK: - PROPERTIES
  static var emptyArray:JSONCollection{
    return JSONCollection.ArrayValue(JSONArray())
  }
  
  
  static var emptyObject:JSONCollection{
    return JSONCollection.ObjectValue(JSONObject())
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
  
  
  //MARK: - SUBSCRIPTS
  // We shouldn't have to break this into «first» and «rest», but it works around a bug where a single variadic argument won't infer type correctly and thus won't pick up subscript's integer- and string-literal convertable code.
  subscript(first:JSONSubscript, rest:JSONSubscript...)->JSONValue?{
    get{
      let initial = Optional(JSONValue(self))
      let subscripts = [first]+rest
      return subscripts.reduce(initial){ last, next in
        return last?.collectionValue?.valueForSubscript(next)
      }
    }
  }

  
  //MARK: - INITIALIZERS
  init?(string:String){
    var noOp:NSError?
    self.init(string:string, error:&noOp)
  }
  
  
  init?(string:String, inout error outError:NSError?){
    switch self.dynamicType.result(string){
    case .Error(let error):
      outError = error
      return nil
    case .Value(let boxed):
      outError = nil
      self = boxed.unbox
    }
  }
  
  
  init?(array:NSArray){
    var noOp:NSError?
    self.init(array:array, error:&noOp)
  }

  
  init?(array:NSArray, inout error outError:NSError?){
    switch self.dynamicType.result(array){
    case .Error(let error):
      outError = error
      return nil
    case .Value(let boxed):
      outError = nil
      self = boxed.unbox
    }
  }
  
  
  init?(dictionary:NSDictionary){
    var noOp:NSError?
    self.init(dictionary:dictionary, error:&noOp)
  }
  
  
  init?(dictionary:NSDictionary, inout error outError:NSError?){
    switch self.dynamicType.result(dictionary){
    case .Error(let error):
      outError = error
      return nil
    case .Value(let boxed):
      outError = nil
      self = boxed.unbox
    }
  }
  
  
  static func result(rawJSON:String)->Result<JSONCollection>{
    return parsedResultFromString(rawJSON).flatMap{ self.collectionResultFromParsedJSON($0) }
  }
  
  
  static func result(array:NSArray)->Result<JSONCollection>{
    let emptyResult = Result(JSONCollection.emptyArray)
    return (array as [AnyObject]).reduce(emptyResult){ last, this in
      return last.flatMap{ arrayCollection in
        switch this{
        case let string as String:
          return arrayCollection.conjoinResult(JSONValue(string))
        case let number as NSNumber:
          return arrayCollection.conjoinResult(JSONValue(number))
        case let array as NSArray:
          return self.result(array).flatMap{ arrayCollection.conjoinResult(JSONValue($0)) }
        case let dictionary as NSDictionary:
          return self.result(dictionary).flatMap{ arrayCollection.conjoinResult(JSONValue($0)) }
        default:
          return .Error(NSError.YanesInvalidJSONValueError())
        }
      }
    }
  }
  
  
  static func result(dictionary:NSDictionary)->Result<JSONCollection>{
    let emptyResult = Result(JSONCollection.emptyObject)
    return reduce(dictionary as [NSObject:AnyObject], emptyResult){ last, this in
      if let key = this.0 as? JSONKey{
        return last.flatMap{ objectCollection in
          switch this.1{
          case let string as String:
            return objectCollection.conjoinResult(JSONValue(string), forKey:key)
          case let number as NSNumber:
            return objectCollection.conjoinResult(JSONValue(number), forKey:key)
          case let array as NSArray:
            return self.result(array).flatMap{ objectCollection.conjoinResult(JSONValue($0), forKey:key) }
          case let dictionary as NSDictionary:
            return self.result(dictionary).flatMap{ objectCollection.conjoinResult(JSONValue($0), forKey:key) }
          default:
            return .Error(NSError.YanesInvalidJSONValueError())
          }
        }
      } else{
        return .Error(NSError.YanesInvalidJSONKeyError())
      }
    }
  }
}



//MARK: - PRIVATE
private extension JSONCollection{
  typealias ParsedJSON = AnyObject
  
  static func parsedResultFromString(rawJSON:String)->Result<ParsedJSON>{
    let data = rawJSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)!
    var error:NSError?
    var object:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:&error)
    if let someError = error{
      return .Error(someError)
    } else{
      return Result(object!)
    }
  }
  
  
  static func collectionResultFromParsedJSON(jsonObject:ParsedJSON)->Result<JSONCollection>{
    switch jsonObject{
    case let array as NSArray:
      return result(array)
    case let dictionary as NSDictionary:
      return result(dictionary)
    default:
      return .Error(NSError.YanesInvalidContainerObjectError())
    }
  }
  
  
  func conjoinResult(addition:JSONValue)->Result<JSONCollection>{
    switch self{
    case .ArrayValue(let array):
      return Result(JSONCollection.ArrayValue(array + [addition]))
    default:
      return .Error(NSError.YanesInvalidContainerObjectError("Append expected collection to have type of ArrayValue"))
    }
  }
  
  
  func conjoinResult(addition:JSONValue, forKey key:JSONKey)->Result<JSONCollection>{
    switch self{
    case .ObjectValue(let object):
      return Result(JSONCollection.ObjectValue(object + [key:addition]))
    default:
      return .Error(NSError.YanesInvalidContainerObjectError("Append expected collection fo have type of ObjectValue"))
    }
  }
  
  
  func valueForSubscript(element:JSONSubscript)->JSONValue?{
    switch element{
    case .Index(let index) where isArray:
      let array = arrayValue!
      return index < count(array) ? array[index] : nil
    case .Key(let key) where isObject:
      return objectValue![key]
    default:
      fatalError("Subscript sent to unexpected JSONCollection type.")
    }
  }

}



//MARK: - PRINTABLE
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
