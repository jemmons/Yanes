import Foundation



public typealias JSONObject = Dictionary<JSONKey,JSON>
public typealias JSONArray = Array<JSON>
public typealias JSONKey = String



public enum ParseError : ErrorType{
  case InvalidContainer
  case InvalidValue
  case InvalidKey
}