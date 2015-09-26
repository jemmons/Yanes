import Foundation



public enum JSONIndex{
  case Index(Int)
  case Key(JSONKey)
  
  public init(_ index:Int){
    self = .Index(index)
  }
  
  
  public init(_ key:JSONKey){
    self = .Key(key)
  }
}



extension JSONIndex : Equatable{}
public func ==(lhs:JSONIndex, rhs:JSONIndex)->Bool{
  switch (lhs, rhs){
  case (.Index(let a), .Index(let b)):
    return a == b
  case (.Key(let a), .Key(let b)):
    return a == b
  default:
    return false
  }
}


extension JSONIndex : IntegerLiteralConvertible{
  public init(integerLiteral value: IntegerLiteralType){
    self = .Index(value)
  }
}



extension JSONIndex : StringLiteralConvertible{
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