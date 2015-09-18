import UIKit
import XCTest
import Yanes


class JSONInitializerTests: XCTestCase {
  func testNumberInitializer(){
    let jsonInteger = 42
    XCTAssertEqual(JSON(jsonInteger), JSON.NumberValue(jsonInteger))
    XCTAssertEqual(JSON(jsonInteger).numberValue!, jsonInteger)
    
    let jsonDouble = 42.42
    XCTAssertEqual(JSON(jsonDouble), JSON.NumberValue(jsonDouble))
    XCTAssertEqual(JSON(jsonDouble).numberValue!, jsonDouble)
    
    let jsonTrue = true //Needed to avoid BoolLiteralConvertible
    XCTAssertEqual(JSON(jsonTrue), JSON.NumberValue(NSNumber(bool:true)))
    XCTAssertEqual(JSON(jsonTrue).numberValue!.boolValue, true)
    
    let jsonFalse = false //Needed to avoid BoolLiteralConvertible
    XCTAssertEqual(JSON(jsonFalse), JSON.NumberValue(NSNumber(bool:false)))
    XCTAssertEqual(JSON(jsonFalse).numberValue!.boolValue, false)
  }
  
  
  func testStringInitializer(){
    let jsonString = "foo"
    XCTAssertEqual(JSON(jsonString), JSON.StringValue(jsonString))
    XCTAssertEqual(JSON(jsonString).stringValue!, jsonString)
  }
  
  
  func testArrayInitialier(){
    let jsonArray = [JSON.NumberValue(1), JSON.NumberValue(2)]
    XCTAssertEqual(JSON(jsonArray), JSON.ArrayValue(jsonArray))
    XCTAssertEqual(JSON(jsonArray).arrayValue!, jsonArray)
  }
  
  
  func testObjectInitializer(){
    let jsonObject = ["foo":JSON.NumberValue(42)]
    XCTAssertEqual(JSON(jsonObject), JSON.ObjectValue(jsonObject))
    XCTAssertEqual(JSON(jsonObject).objectValue!, jsonObject)
  }
}
