import Foundation
//TODO: Don't forget about DictionaryLiteralConvertible and ArrayLiteralConvertible!



extension JSON : IntegerLiteralConvertible{
  public init(integerLiteral value: IntegerLiteralType) {
    self = .NumberValue(value)
  }
}



extension JSON : FloatLiteralConvertible{
  public init(floatLiteral value: FloatLiteralType) {
    self = .NumberValue(value)
  }
}



extension JSON : StringLiteralConvertible{
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



extension JSON : CustomDebugStringConvertible{
  public var debugDescription:String{
    switch self{
    case .StringValue(let string):
      return string.debugDescription
    case .NumberValue(let number):
      return number.debugDescription
    case .ArrayValue(let array):
      return array.debugDescription
    case .ObjectValue(let dictionary):
      return dictionary.debugDescription
    case .NullValue:
      return "<null>"
    }
  }
}
