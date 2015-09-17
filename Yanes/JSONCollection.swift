//import Foundation
//import Rebar
//
//public enum JSONCollection{
//  case ObjectValue(JSONObject)
//  case ArrayValue(JSONArray)
//}
//
//
//
//public extension JSONCollection{
//  //MARK: - SUBSCRIPTS
//  // We shouldn't have to break this into «first» and «rest», but it works around a bug where a single variadic argument won't infer type correctly and thus won't pick up subscript's integer- and string-literal convertable code.
//  subscript(first:JSONSubscript, rest:JSONSubscript...)->JSON?{
//    get{
//      let initial = Optional(JSON(self))
//      let subscripts = [first]+rest
//      return subscripts.reduce(initial){ last, next in
//        return last?.collectionValue?.valueForSubscript(next)
//      }
//    }
//  }
//
//
//
////MARK: - PRIVATE
//private extension JSONCollection{
//  func valueForSubscript(element:JSONSubscript)->JSON?{
//    switch element{
//    case .Index(let index) where isArray:
//      let array = arrayValue!
//      return index < count(array) ? array[index] : nil
//    case .Key(let key) where isObject:
//      return objectValue![key]
//    default:
//      fatalError("Subscript sent to unexpected JSONCollection type.")
//    }
//  }
//
//}
//
//
//
////MARK: - PRINTABLE
//extension JSONCollection : Printable{
//  public var description:String{
//    switch self{
//    case .ObjectValue(let object):
//      return object.description
//    case .ArrayValue(let array):
//      return array.description
//    }
//  }
//}
