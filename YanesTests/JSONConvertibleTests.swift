import Foundation
import XCTest
import Yanes


class JSONConvertibleTests : XCTestCase{
  func testStringLiteralConvertible(){
    let stringAnswer = JSON(string:"foo")
    
    let json:JSON = "foo"
    XCTAssertEqual(json, stringAnswer)

    let jsonArray:JSONArray = ["foo"]
    XCTAssertEqual(jsonArray.first, stringAnswer)
    
    let jsonObject:JSONObject = ["key":"foo"]
    XCTAssertEqual(jsonObject["key"]!, stringAnswer)
  }
  

  func testNumberLiteralConvertible(){
    let intAnswer = JSON(number: NSNumber(integer: 42))
    let doubleAnswer = JSON(number: NSNumber(double: 42.42))
    let boolAnswer = JSON(number: NSNumber(bool: true))
    
    var json:JSON = 42
    XCTAssertEqual(json, intAnswer)
    json = 42.42
    XCTAssertEqual(json, doubleAnswer)
    json = true
    XCTAssertEqual(json, boolAnswer)
    
    var jsonArray:JSONArray = [42]
    XCTAssertEqual(jsonArray.first, intAnswer)
    jsonArray = [42.42]
    XCTAssertEqual(jsonArray.first, doubleAnswer)
    jsonArray = [true]
    XCTAssertEqual(jsonArray.first, boolAnswer)
    
    var jsonObject:JSONObject = ["key":42]
    XCTAssertEqual(jsonObject["key"]!, intAnswer)
    jsonObject = ["key":42.42]
    XCTAssertEqual(jsonObject["key"]!, doubleAnswer)
    jsonObject = ["key":true]
    XCTAssertEqual(jsonObject["key"]!, boolAnswer)
  }

  
  func testArrayLiteralConvertible(){
    let arrayAnswer = JSON(array: [JSON(number:1), JSON(number:2), JSON(number:3)])
    
    let json:JSON = [1,2,3]
    XCTAssertEqual(json, arrayAnswer)
    
    let jsonArray:JSONArray = [[1,2,3]]
    XCTAssertEqual(jsonArray.first, arrayAnswer)
    
    let jsonObject:JSONObject = ["key":[1,2,3]]
    XCTAssertEqual(jsonObject["key"]!, arrayAnswer)
  }
  
  
  func testDictionaryLiteralConvertible(){
    let objectAnswer = JSON(object: ["one":JSON(number:1), "two":JSON(number:2), "three":JSON(number:3)])
    
    let json:JSON = ["one":1, "two":2, "three":3]
    XCTAssertEqual(json, objectAnswer)
    
    let jsonArray:JSONArray = [["one":1, "two":2, "three":3]]
    XCTAssertEqual(jsonArray.first, objectAnswer)
    
    let jsonObject:JSONObject = ["key":["one":1, "two":2, "three":3]]
    XCTAssertEqual(jsonObject["key"]!, objectAnswer)
  }
}

