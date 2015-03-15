import Foundation

public enum JSONValue{
  case StringValue(String)
  case NumberValue(NSNumber)
  case CollectionValue(JSONCollection)

  
  func more()->JSONCollection?{
    switch self{
    case .CollectionValue(let collection):
      return collection
    default:
      return nil
    }
  }
}



public extension JSONValue{
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

