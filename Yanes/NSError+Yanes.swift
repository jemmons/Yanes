import Foundation

public extension NSError{
  public enum YanesCodes:Int{
    case InvalidContainerObject = 1, InvalidJSONValue
  }
  
  public static var yanesDomain:String{ return "com.mcmxcix.yanes" }
  static func YanesInvalidContainerObjectError()->NSError{
    return NSError(domain: yanesDomain, code:YanesCodes.InvalidContainerObject.rawValue, userInfo:[NSLocalizedDescriptionKey:"JSON container objects must be either dictionaries or arrays."])
  }
  static func YanesInvalidJSONValueError()->NSError{
    return NSError(domain: yanesDomain, code:YanesCodes.InvalidJSONValue.rawValue, userInfo:[NSLocalizedDescriptionKey:"JSON values must be strings, numbers, arrays, or dictionaries."])
  }
}