import UIKit
import XCTest
import Yanes


class JSONInitializerTests: XCTestCase {
  func testNumberInitializer(){
    let jsonInteger = 42
    XCTAssertEqual(JSON(jsonInteger), JSON.Number(jsonInteger))
    XCTAssertEqual(JSON(jsonInteger).numberValue!, jsonInteger)
    
    let jsonDouble = 42.42
    XCTAssertEqual(JSON(jsonDouble), JSON.Number(jsonDouble))
    XCTAssertEqual(JSON(jsonDouble).numberValue!, jsonDouble)
    
    let jsonTrue = true //Needed to avoid BoolLiteralConvertible
    XCTAssertEqual(JSON(jsonTrue), JSON.Number(NSNumber(bool:true)))
    XCTAssertEqual(JSON(jsonTrue).numberValue!.boolValue, true)
    
    let jsonFalse = false //Needed to avoid BoolLiteralConvertible
    XCTAssertEqual(JSON(jsonFalse), JSON.Number(NSNumber(bool:false)))
    XCTAssertEqual(JSON(jsonFalse).numberValue!.boolValue, false)
  }
  
  
  func testStringInitializer(){
    let jsonString = "foo"
    XCTAssertEqual(JSON(jsonString), JSON.String(jsonString))
    XCTAssertEqual(JSON(jsonString).stringValue!, jsonString)
  }
  
  
  func testArrayInitialier(){
    let jsonArray = [JSON.Number(1), JSON.Number(2)]
    XCTAssertEqual(JSON(jsonArray), JSON.Array(jsonArray))
    XCTAssertEqual(JSON(jsonArray).arrayValue!, jsonArray)
  }
  
  
  func testObjectInitializer(){
    let jsonObject = ["foo":JSON.Number(42)]
    XCTAssertEqual(JSON(jsonObject), JSON.Object(jsonObject))
    XCTAssertEqual(JSON(jsonObject).objectValue!, jsonObject)
  }
}
