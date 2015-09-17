import Foundation



extension JSON : Equatable{}

public func ==(lhs: JSON, rhs: JSON) -> Bool{
  switch (lhs, rhs){
  case (.StringValue(let a), .StringValue(let b)):
    return a == b
  case (.NumberValue(let a), .NumberValue(let b)):
    return a == b
  case (.ArrayValue(let a), .ArrayValue(let b)):
    return a == b
  case (.ObjectValue(let a), .ObjectValue(let b)):
    return a == b
  case (.NullValue, .NullValue):
    return true
  default:
    return false
  }
}
