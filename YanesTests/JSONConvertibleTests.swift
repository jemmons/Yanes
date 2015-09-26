import Foundation
import XCTest
import Yanes


class JSONConvertibleTests : XCTestCase{
  func testStringLiteralConvertible(){
    let stringAnswer = JSON.String("foo")
    
    let json:JSON = "foo"
    XCTAssertEqual(json, stringAnswer)

    let jsonArray:JSONArray = ["foo"]
    XCTAssertEqual(jsonArray.first, stringAnswer)
    
    let jsonObject:JSONObject = ["key":"foo"]
    XCTAssertEqual(jsonObject["key"]!, stringAnswer)
  }
  

  func testNumberLiteralConvertible(){
    let intAnswer = JSON.Number(NSNumber(integer:42))
    let doubleAnswer = JSON.Number(NSNumber(double: 42.42))
    let boolAnswer = JSON.Number((NSNumber(bool: true)))
    
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
    let arrayAnswer = JSON.Array([JSON.Number(1), JSON.Number(2), JSON.Number(3)])
    
    let json:JSON = [1,2,3]
    XCTAssertEqual(json, arrayAnswer)
    
    let jsonArray:JSONArray = [[1,2,3]]
    XCTAssertEqual(jsonArray.first, arrayAnswer)
    
    let jsonObject:JSONObject = ["key":[1,2,3]]
    XCTAssertEqual(jsonObject["key"]!, arrayAnswer)
  }
  
  
  func testDictionaryLiteralConvertible(){
    let objectAnswer = JSON.Object(["one":JSON.Number(1), "two":JSON.Number(2), "three":JSON.Number(3)])
    
    let json:JSON = ["one":1, "two":2, "three":3]
    XCTAssertEqual(json, objectAnswer)
    
    let jsonArray:JSONArray = [["one":1, "two":2, "three":3]]
    XCTAssertEqual(jsonArray.first, objectAnswer)
    
    let jsonObject:JSONObject = ["key":["one":1, "two":2, "three":3]]
    XCTAssertEqual(jsonObject["key"]!, objectAnswer)
  }
}

