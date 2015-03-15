import Foundation
import Result

public struct JSON{
  typealias DictionaryPair = (key:AnyObject, value:AnyObject)
  typealias JSONPair = (key:JSONKey, value:JSONValue)
  
  
//  static func jsonFromString(rawJSON:String)->Result<JSON>{
//    return jsonObjectFromString(string).fmap(jsonFromJSONObject)
//  }
}
  
//  static func jsonFromJSONObject(jsonObject:NSDictionary)->Result<JSON>{
//    var json = JSON()
//    for dictionaryElement in jsonObject{
//      switch jsonElementFromDictionaryElement(dictionaryElement){
//      case .Error(let error):
//        return Result.Error(error)
//      case .Value(let boxedElement):
//        break
////        json[boxedElement.unbox.key] = boxedElement.unbox.value
//      }
//    }
//    return Result.Value(Box(json))
//  }
//  
//  
//  /**
//  We would like this to be a member method on the JSON type. But sadly we can't add members to typealiases yet.
//  */
////  static func digJSON(json:JSON, keyPath keys:JSONKey...)->JSONValue?{
////    var cursor:JSON? = json
////    for key in keys[0..<keys.count-1]{
////      if cursor != nil{
////        cursor = cursor![key]?.more()
////      }
////    }
////    return cursor?[keys.last!]
////  }
//}
//
//
//
//private extension JSON{
//  static func jsonObjectFromString(string:String)->Result<NSDictionary>{
//    var response:Result<NSDictionary> = .Error(.unknownError)
//    if let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false){
//      var error:NSError?
//      if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:&error) as? NSDictionary{
//        response = .Value(Box(jsonObject))
//      }else if error != nil{
//        response = .Error(error!)
//      }
//    } else{
//      response = .Error(NSError(domain:"ReverbJSONErrorDomain", code:102, userInfo:[NSLocalizedDescriptionKey:"Unable to convert string to data."]))
//    }
//    return response
//  }
//  
//  
//  static func jsonElementFromDictionaryElement(element:DictionaryElement)->Result<JSONElement>{
//    var response = Result<JSONElement>.Error(NSError(domain:"ReverbUnknownErrorDomain", code:-1, userInfo:nil))
//    if let jsonKey = element.key as? JSONKey{
//      response = jsonValueFromDictionaryValue(element.value).fmap{ jsonValue in Result<JSONElement>.Value(Box((key:jsonKey, value:jsonValue))) }
//    }else{
//      response = Result.Error(NSError(domain:"ReverbJSONErrorDomain", code:100, userInfo:[NSLocalizedDescriptionKey:"Invalid JSON key encountered."]))
//    }
//    return response
//  }
//  
//  
//  static func jsonValueFromDictionaryValue(value:AnyObject)->Result<JSONValue>{
//    switch value{
//    case let string as String:
//      return Result.Value(Box(JSONValue.StringValue(string)))
//    case let number as NSNumber:
//      return Result.Value(Box(JSONValue.NumberValue(number)))
////    case let jsonObject as NSDictionary:
////      return jsonFromJSONObject(jsonObject).fmap{ json in
////        let nested = JSONNested.ObjectValue(json)
////        return Result.Value(Box(.NestedValue(nested))) }
//    default:
//      return Result.Error(NSError(domain:"ReverbJSONErrorDomain", code:101, userInfo:[NSLocalizedDescriptionKey:"Invalid JSON value encountered."]))
//    }
//  }
//  
//}
//
//
////Usage
////switch JSONKit.jsonFromString("{\"foo\": \"Stuff\", \"bar\": {\"baz\": 700}}"){
////case .Error(let error):
////  println("Error: \(error)")
////case .Value(let json):
////  let bar = JSONKit.digJSON(json(), keyPath:"bar", "foo", "baz")
////  println("JSON: \(bar)")
////  
////}
//
