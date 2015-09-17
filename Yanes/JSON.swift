import Foundation

public enum JSON{
  case StringValue(String)
  case NumberValue(NSNumber)
  case NullValue
  indirect case ObjectValue(JSONObject)
  indirect case ArrayValue(JSONArray)
}



public extension JSON{
  init(number:NSNumber){
    self = JSON.NumberValue(number)
  }
  
  
  init(string:String){
    self = JSON.StringValue(string)
  }


  init(array:JSONArray){
    self = JSON.ArrayValue(array)
  }


  init(object:JSONObject){
    self = JSON.ObjectValue(object)
  }
}
