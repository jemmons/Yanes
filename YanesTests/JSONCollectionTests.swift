import Foundation
import XCTest
import Yanes


class JSONCollectionTests: XCTestCase {
  let jsonArray = try! JSON.parseArray([1,2,3,4,5])
  let jsonObject = try! JSON.parseDictionary(["one":1,"two":2,"three":3,"four":4,"five":5])
  let jsonString = JSON.StringValue("foo")
  let jsonNumber = JSON.NumberValue(42)

  //MARK: - ARRAY
  func testArrayForIn(){
    var memo = 0
    for subject in jsonArray{
      memo += subject.numberValue!.integerValue
    }
    XCTAssertEqual(memo, 15)
  }
  
  
  func testArrayForEach(){
    var memo = 0
    jsonArray.forEach{ memo += $0.numberValue!.integerValue }
    XCTAssertEqual(memo, 15)
  }

  
  func testArrayMap(){
    let subject = jsonArray.map{ $0.numberValue! }
    XCTAssertEqual(subject, [1,2,3,4,5])
  }
  
  
  func testArrayFilter(){
    let subject = jsonArray.filter{ $0.numberValue!.integerValue % 2 == 0 }.map{ $0.numberValue! }
    XCTAssertEqual(subject, [2,4])
  }
  
  
  //MARK: - OBJECT
  func testObjectForIn(){
    var memo = 0
    for subject in jsonObject{
      memo += subject.numberValue!.integerValue
    }
    XCTAssertEqual(memo, 15)
  }
  
  
  func testObjectForEach(){
    var memo = 0
    jsonObject.forEach{ memo += $0.numberValue!.integerValue }
    XCTAssertEqual(memo, 15)
  }
  
  
  func testObjectMap(){
    let subject = jsonObject.map{ $0.numberValue! }
    XCTAssertEqual(Set(subject), Set([1,2,3,4,5]))
  }
  
  
  func testObjectFilter(){
    let subject = jsonObject.filter{ $0.numberValue!.integerValue % 2 == 0 }.map{ $0.numberValue! }
    XCTAssertEqual(Set(subject), Set([2,4]))
  }

  
  //MARK: - STRING
  func testStringForIn(){
    var memo = ""
    for subject in jsonString{
      memo += subject.stringValue!
    }
    XCTAssertEqual(memo, "foo")
  }
  
  
  func testStringForEach(){
    var memo = ""
    jsonString.forEach{ memo += $0.stringValue! }
    XCTAssertEqual(memo, "foo")
  }
  
  
  func testStringMap(){
    let subject = jsonString.map{ $0.stringValue! }
    XCTAssertEqual(subject, ["foo"])
  }
  
  
  //MARK: - NUMBER
  func testNumberForIn(){
    var memo = 0
    for subject in jsonNumber{
      memo += subject.numberValue!.integerValue
    }
    XCTAssertEqual(memo, 42)
  }
  
  
  func testNumberForEach(){
    var memo = 0
    jsonNumber.forEach{ memo += $0.numberValue!.integerValue }
    XCTAssertEqual(memo, 42)
  }
  
  
  func testNumberMap(){
    let subject = jsonNumber.map{ $0.numberValue!.integerValue }
    XCTAssertEqual(subject, [42])
  }
  
  
  //MARK: - NULL
  func testNullForIn(){
    for _ in JSON.NullValue{
      XCTFail()
    }
  }
  
  
  func testNullForEach(){
    JSON.NullValue.forEach{ _ in XCTFail() }
  }
  
  
  func testNullMap(){
    let subject:[Int] = JSON.NullValue.map{ (_)->Int in
      XCTFail()
      return 1
    }
    XCTAssertEqual(subject, [Int]())
  }
}
