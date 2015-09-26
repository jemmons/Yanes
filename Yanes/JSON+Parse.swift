import Foundation
import Rebar


public extension JSON{
  static func parseString(string:Swift.String) throws -> JSON{
    return try parseUntypedJSON(parseString(string))
  }
  
  static func parseDictionary(dictionary:NSDictionary) throws -> JSON{
    return try parseUntypedDictionary(dictionary)
  }
  
  static func parseArray(array:NSArray) throws -> JSON{
    return try parseUntypedArray(array)
  }
}



private extension JSON{
  typealias UntypedJSON = AnyObject
  typealias UntypedDictionary = NSDictionary
  typealias UntypedArray = NSArray
  
  
  static func parseString(rawJSON:Swift.String) throws -> UntypedJSON{
    //Can never be nil if allowLossy is true.
    let data = rawJSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)!
    return try NSJSONSerialization.JSONObjectWithData(data, options:[]) as UntypedJSON
  }
  
  
  static func parseUntypedJSON(untypedJSON:UntypedJSON) throws -> JSON{
    switch untypedJSON{
    case let array as UntypedArray:
      return try parseUntypedArray(array)
    case let dictionary as UntypedDictionary:
      return try parseUntypedDictionary(dictionary)
    default:
      throw ParseError.InvalidContainer
    }
  }
  
  
  static func parseUntypedArray(untypedArray:UntypedArray) throws -> JSON{
    let jsonArray = try (untypedArray as [AnyObject]).map{ it throws -> JSON in
      switch it{
      case let string as Swift.String:
        return JSON.String(string)
      case let number as NSNumber:
        return JSON.Number(number)
      case let array as UntypedArray:
        return try parseUntypedArray(array)
      case let dictionary as UntypedDictionary:
        return try parseUntypedDictionary(dictionary)
      case is NSNull:
        return JSON.Null
      default:
        throw ParseError.InvalidValue
      }
    }
    
    return JSON.Array(jsonArray)
  }
  
  
  static func parseUntypedDictionary(untypedDictionary:UntypedDictionary) throws -> JSON{
    let jsonObject = try (untypedDictionary as [NSObject:AnyObject]).mapPairs{ key, value throws -> (JSONKey, JSON) in
      guard let key = key as? JSONKey else{
        throw ParseError.InvalidKey
      }
      switch value{
      case let string as Swift.String:
        return (key, JSON.String(string))
      case let number as NSNumber:
        return (key, JSON.Number(number))
      case let array as UntypedArray:
        return (key, try parseUntypedArray(array))
      case let dictionary as UntypedDictionary:
        return (key, try parseUntypedDictionary(dictionary))
      case is NSNull:
        return (key, JSON.Null)
      default:
        throw ParseError.InvalidValue
      }
    }
    
    return JSON.Object(jsonObject)
  }
}