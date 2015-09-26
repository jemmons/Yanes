import Foundation



extension JSON : Equatable{}

public func ==(lhs: JSON, rhs: JSON) -> Bool{
  switch (lhs, rhs){
  case (.String(let a), .String(let b)):
    return a == b
  case (.Number(let a), .Number(let b)):
    return a == b
  case (.Array(let a), .Array(let b)):
    return a == b
  case (.Object(let a), .Object(let b)):
    return a == b
  case (.Null, .Null):
    return true
  default:
    return false
  }
}
