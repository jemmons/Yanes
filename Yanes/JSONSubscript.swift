import Foundation

enum JSONSubscript : IntegerLiteralConvertible{
  case Index(Int)
  case Key(JSONKey)
  init(integerLiteral value: IntegerLiteralType){
    self = .Index(value)
  }
}

