import Foundation
import XCTest
import Yanes

class JSONMutableArrayTests : XCTestCase{
  func testAppendArray(){
    var subject = JSON.Array([JSON.Number(1)])
    subject.append(JSON.Number(2))
    
    XCTAssertEqual(subject.arrayValue!, [JSON.Number(1), JSON.Number(2)])
  }

  
  func testReplaceArrayValue(){
    var subject = try! JSON.parseArray([1,2])
    subject[1] = JSON.String("foo")
    XCTAssertEqual(subject.arrayValue!, [JSON.Number(1), JSON.String("foo")])
  }

  
  func testAppendNestedArray(){
    var subject = try! JSON.parseArray([1,["a","b",["i", "ii"]]])
    subject[1][2].append(JSON.String("iii"))
    XCTAssertEqual(subject.arrayValue!, [JSON.Number(1), [JSON.String("a"), JSON.String("b"), [JSON.String("i"), JSON.String("ii"), JSON.String("iii")]]])
  }

  
  func testReplaceValueAtNestedArraySubscript(){
    var subject = try! JSON.parseArray([1,["a","b",["i", "ii"]]])
    subject[1][2] = JSON.String("foo")
    XCTAssertEqual(subject.arrayValue!, [JSON.Number(1), [JSON.String("a"), JSON.String("b"), JSON.String("foo")]])
  }
  
  
  func testAppendArrayAtDictionarySubscript(){
    var subject = try! JSON.parseString("{\"foo\":[42]}")
    subject["foo"]!.append(JSON.Number(64))
    XCTAssertEqual(subject.objectValue!, ["foo":JSON.Array([JSON.Number(42), JSON.Number(64)])])
  }
  
  
  func testAppendArrayAtMixedSubscript(){
    var subject = try! JSON.parseDictionary(["foo":[["bar":[42]]]])
    subject["foo"]![0]["bar"]!.append(JSON.Number(64))
    XCTAssertEqual(subject.objectValue!, ["foo":JSON.Array([JSON.Object(["bar":JSON.Array(([JSON.Number(42), JSON.Number(64)]))])])])
  }
  
  
  func testReplaceArrayAtMixedSubscript(){
    var subject = try! JSON.parseDictionary(["foo":[["bar":[42]]]])
    subject["foo", 0, "bar"]!.append(JSON.Number(64))
    XCTAssertEqual(subject.objectValue!, ["foo":JSON.Array([JSON.Object(["bar":JSON.Array(([JSON.Number(42), JSON.Number(64)]))])])])
  }
}