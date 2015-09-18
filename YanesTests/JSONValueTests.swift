import UIKit
import XCTest
import Yanes

class JSONTests: XCTestCase {
  func testStringValue(){
    let string = JSON.StringValue("String")
    XCTAssertEqual(string.stringValue!, "String")
    XCTAssert(string.isString)
    XCTAssertFalse(string.isArray)
    XCTAssertFalse(string.isObject)
    XCTAssertFalse(string.isNumber)
    XCTAssertFalse(string.isNull)
  }


  func testNumberValue(){
    let integer = JSON.NumberValue(42)
    XCTAssertEqual(integer.numberValue!, 42)
    XCTAssertEqual(integer.numberValue!, 42.0)
    XCTAssert(integer.isNumber)
    XCTAssertFalse(integer.isArray)
    XCTAssertFalse(integer.isObject)
    XCTAssertFalse(integer.isString)
    XCTAssertFalse(integer.isNull)
  }

  
  func testArrayValue(){
    let jsonArray = [JSON.NumberValue(1), JSON.NumberValue(2), JSON.NumberValue(3)]
    let array = JSON.ArrayValue(jsonArray)
    XCTAssertEqual(array.arrayValue!, jsonArray)
    XCTAssert(array.isArray)
    XCTAssertFalse(array.isNumber)
    XCTAssertFalse(array.isObject)
    XCTAssertFalse(array.isString)
    XCTAssertFalse(array.isNull)
  }

  
  func testObjectValue(){
    let jsonObject = ["one":JSON.NumberValue(1)]
    let object = JSON.ObjectValue(jsonObject)
    XCTAssertEqual(object.objectValue!, jsonObject)
    XCTAssert(object.isObject)
    XCTAssertFalse(object.isNumber)
    XCTAssertFalse(object.isArray)
    XCTAssertFalse(object.isString)
    XCTAssertFalse(object.isNull)
  }

  
  func testNullValue(){
    let subject = JSON.NullValue
    XCTAssert(subject.isNull)
    XCTAssertFalse(subject.isNumber)
    XCTAssertFalse(subject.isArray)
    XCTAssertFalse(subject.isString)
    XCTAssertFalse(subject.isObject)
  }

  
  func testStringConvertible(){
    let subject:JSON = "String"
    XCTAssertEqual(subject.stringValue!, "String")
  }
  
  
  func testStringValuePolymorphism(){
    let subject = JSON.StringValue("foo")
    let string:String? = subject.val()
    XCTAssertEqual(string, "foo")
  }


  func testNegativeStringValuePolymorphism(){
    let subject = JSON.NumberValue(42)
    let string:String? = subject.val()
    XCTAssert(string == nil)
  }
  
  
  func testNumberValuePolymorphism(){
    let subject = JSON.NumberValue(42.42)
    let int:Int? = subject.val()
    let double:Double? = subject.val()
    let bool:Bool? = subject.val()
    XCTAssertEqual(int!, 42)
    XCTAssertEqual(double!, 42.42)
    XCTAssertEqual(bool!, true)
  }

  
  func testNegativeNumberValuePolymorphism(){
    let subject = JSON.StringValue("foo")
    let int:Int? = subject.val()
    let double:Double? = subject.val()
    let bool:Bool? = subject.val()
    XCTAssert(int == nil)
    XCTAssert(double == nil)
    XCTAssert(bool == nil)
  }
  
  
  func testArrayValuePolymorphism(){
    let subject = try! JSON.parseArray([1,2,3])
    let array:JSONArray? = subject.val()
    XCTAssertEqual(array!, [JSON.NumberValue(1), JSON.NumberValue(2), JSON.NumberValue(3)])
  }
  
  
  func testNegativeArrayValuePolymorphism(){
    let subject = JSON.NumberValue(42)
    let array:JSONArray? = subject.val()
    XCTAssert(array == nil)
  }
  
  
  func testObjectValuePolymorphism(){
    let subject = try! JSON.parseDictionary(["one":1, "two":2])
    let object:JSONObject? = subject.val()
    XCTAssertEqual(object!, ["one":JSON.NumberValue(1), "two":JSON.NumberValue(2)])
  }
  
  
  func testNegativeObjectValuePolymorphism(){
    let subject = JSON.NumberValue(42)
    let object:JSONObject? = subject.val()
    XCTAssert(object == nil)
  }
}
