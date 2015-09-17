import UIKit
import XCTest
import Yanes


class JSONInitializerTests: XCTestCase {
  func testNumberInitializer(){
    let jsonInteger = 42
    XCTAssertEqual(JSON(number:jsonInteger), JSON.NumberValue(jsonInteger))
    XCTAssertEqual(JSON(number:jsonInteger).numberValue!, jsonInteger)
    
    let jsonDouble = 42.42
    XCTAssertEqual(JSON(number:jsonDouble), JSON.NumberValue(jsonDouble))
    XCTAssertEqual(JSON(number:jsonDouble).numberValue!, jsonDouble)
    
    XCTAssertEqual(JSON(number:true), JSON.NumberValue(true))
    XCTAssertEqual(JSON(number:true).numberValue!, true)
    XCTAssertEqual(JSON(number:true).numberValue!.boolValue, true)
    
    XCTAssertEqual(JSON(number:false), JSON.NumberValue(false))
    XCTAssertEqual(JSON(number:false).numberValue!, false)
    XCTAssertEqual(JSON(number:false).numberValue!.boolValue, false)
  }
  
  
  func testStringInitializer(){
    let jsonString = "foo"
    XCTAssertEqual(JSON(string:jsonString), JSON.StringValue(jsonString))
    XCTAssertEqual(JSON(string:jsonString).stringValue!, jsonString)
  }
  
  
  func testArrayInitialier(){
    let jsonArray = [JSON(number:1), JSON(number:2)]
    XCTAssertEqual(JSON(array:jsonArray), JSON.ArrayValue(jsonArray))
    XCTAssertEqual(JSON(array:jsonArray).arrayValue!, jsonArray)
  }
  
  
  func testObjectInitializer(){
    let jsonObject = ["foo":JSON(number:42)]
    XCTAssertEqual(JSON(object:jsonObject), JSON.ObjectValue(jsonObject))
    XCTAssertEqual(JSON(object:jsonObject).objectValue!, jsonObject)
  }

}
