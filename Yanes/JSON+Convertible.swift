import Foundation
//TODO: Don't forget about DictionaryLiteralConvertible and ArrayLiteralConvertible!



extension JSON : IntegerLiteralConvertible{
  public init(integerLiteral value: IntegerLiteralType) {
    self = .Number(value)
  }
}



extension JSON : FloatLiteralConvertible{
  public init(floatLiteral value: FloatLiteralType) {
    self = .Number(value)
  }
}



extension JSON : BooleanLiteralConvertible{
  public init(booleanLiteral value:Bool) {
    self = .Number(NSNumber(bool:value))
  }
}



extension JSON : StringLiteralConvertible{
  public init(stringLiteral value: Swift.String){
    self = .String(value)
  }
  
  public init(extendedGraphemeClusterLiteral value: Swift.String){
    self = .String(value)
  }
  
  public init(unicodeScalarLiteral value: Swift.String){
    self = .String(value)
  }
}



extension JSON : ArrayLiteralConvertible{
  public init(arrayLiteral elements:JSON...){
    self = .Array(elements)
  }
}



extension JSON : DictionaryLiteralConvertible{
  public init(dictionaryLiteral elements:(JSONKey, JSON)...){
    self = .Object(Dictionary(pairs: elements))
  }
}


extension JSON : CustomDebugStringConvertible{
  public var debugDescription:Swift.String{
    switch self{
    case .String(let string):
      return string.debugDescription
    case .Number(let number):
      return number.debugDescription
    case .Array(let array):
      return array.debugDescription
    case .Object(let dictionary):
      return dictionary.debugDescription
    case .Null:
      return "<null>"
    }
  }
}
