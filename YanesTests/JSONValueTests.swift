import UIKit
import XCTest
import Yanes

class JSONValueTests: XCTestCase {
  func testStringValue(){
    let string = JSONValue.StringValue("String")
    XCTAssertEqual(string.stringValue!, "String")

    let negative = JSONValue.NumberValue(42)
    XCTAssertNil(negative.stringValue)
  }
  
  func testStringConvertible(){
    let subject:JSONValue = "String"
    XCTAssertEqual(subject.stringValue!, "String")
  }
}
