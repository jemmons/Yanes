import Foundation

//public enum JSONIndex : BidirectionalIndexType{
//  case Index(Int)
//  case Key(JSONKey)
//}
//
//
//
//extension JSONIndex : IntegerLiteralConvertible{
//  public init(integerLiteral value: IntegerLiteralType){
//    self = .Index(value)
//  }
//}
//
//
//
//extension JSONIndex : StringLiteralConvertible{
//  public init(stringLiteral value: String) {
//    self = .Key(value)
//  }
//  
//  public init(unicodeScalarLiteral value: String){
//    self = .Key(value)
//  }
//  
//  public init(extendedGraphemeClusterLiteral value: String){
//    self = .Key(value)
//  }
//}