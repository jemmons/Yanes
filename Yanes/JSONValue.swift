import Foundation

public enum JSONValue{
  case StringValue(String)
  case NumberValue(NSNumber)
  case CollectionValue(JSONCollection)
}



public extension JSONValue{
  init(_ value:String){
    self = .StringValue(value)
  }
  
  
  init(_ value:NSNumber){
    self = .NumberValue(value)
  }
  
  
  init(_ value:JSONCollection){
    self = .CollectionValue(value)
  }
  
  
  init(_ value:JSONObject){
    self = .CollectionValue(JSONCollection.ObjectValue(value))
  }
  
  
  init(_ value:JSONArray){
    self = .CollectionValue(JSONCollection.ArrayValue(value))
  }
  
  
  var stringValue:String?{
    switch self{
    case .StringValue(let string):
      return string
    default:
      return nil
    }
  }
  
  
  var numberValue:NSNumber?{
    switch self{
    case .NumberValue(let number):
      return number
    default:
      return nil
    }
  }

  
  var collectionValue:JSONCollection?{
    switch self{
    case .CollectionValue(let collection):
      return collection
    default:
      return nil
    }
  }
  
  
  func toString()->String{
    switch self{
    case .StringValue(let string):
      return string
    case .NumberValue(let number):
      return number.stringValue
    case .CollectionValue(let container):
      return container.description
    }
  }
}



extension JSONValue : StringLiteralConvertible{
  public init(stringLiteral value: String){
    self = .StringValue(value)
  }
  
  public init(extendedGraphemeClusterLiteral value: String){
    self = .StringValue(value)
  }
  
  public init(unicodeScalarLiteral value: String){
    self = .StringValue(value)
  }
}



extension JSONValue : IntegerLiteralConvertible{
  public init(integerLiteral value: IntegerLiteralType) {
    self = .NumberValue(value)
  }
}



extension JSONValue : FloatLiteralConvertible{
  public init(floatLiteral value: FloatLiteralType) {
    self = .NumberValue(value)
  }
}


//Don't forget about DictionaryLiteralConvertible and ArrayLiteralConvertible