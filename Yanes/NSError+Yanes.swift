import Foundation

public extension NSError{
  public enum YanesCodes:Int{
    case InvalidContainerObject = 1, InvalidJSONValue, InvalidJSONKey, NotImplemented
  }
  
  public static var yanesDomain:String{ return "com.mcmxcix.yanes" }
  static func YanesInvalidContainerObjectError(_ description:String? = nil)->NSError{
    let userInfo = [NSLocalizedDescriptionKey: description ?? "JSON container objects must be either dictionaries or arrays."]
    return NSError(domain: yanesDomain, code:YanesCodes.InvalidContainerObject.rawValue, userInfo:userInfo)
  }
  static func YanesInvalidJSONValueError()->NSError{
    return NSError(domain: yanesDomain, code:YanesCodes.InvalidJSONValue.rawValue, userInfo:[NSLocalizedDescriptionKey:"JSON values must be strings, numbers, arrays, or dictionaries."])
  }
  static func YanesInvalidJSONKeyError()->NSError{
    return NSError(domain: yanesDomain, code:YanesCodes.InvalidJSONKey.rawValue, userInfo:[NSLocalizedDescriptionKey:"JSON keys must be strings."])
  }
  static func YanesNotImplementedError(_ description:String?=nil)->NSError{
    let userInfo = [NSLocalizedDescriptionKey: description ?? "This functionality has not yet been implemented."]
    return NSError(domain: yanesDomain, code:YanesCodes.NotImplemented.rawValue, userInfo:userInfo)
  }
}