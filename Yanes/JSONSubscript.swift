import Foundation

public enum JSONSubscript{
  case Index(Int)
  case Key(JSONKey)
}



extension JSONSubscript : IntegerLiteralConvertible{
  public init(integerLiteral value: IntegerLiteralType){
    self = .Index(value)
  }
}



extension JSONSubscript : StringLiteralConvertible{
  public init(stringLiteral value: String) {
    self = .Key(value)
  }
  
  public init(unicodeScalarLiteral value: String){
    self = .Key(value)
  }
  
  public init(extendedGraphemeClusterLiteral value: String){
    self = .Key(value)
  }
}