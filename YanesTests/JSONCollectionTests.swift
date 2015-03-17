import UIKit
import XCTest
import Yanes

class JSONCollectionTests: XCTestCase {
  func testMalformedString(){
    let malformed = JSONCollection(string:"not JSON")
    XCTAssert(malformed == nil)
  }
  
  
  func testArrayFromString(){
    let collectionArray = JSONCollection(string:"[\"foo\", 42]")
    XCTAssert(collectionArray != nil)
    XCTAssertTrue(collectionArray!.isArray)
    XCTAssertFalse(collectionArray!.isObject)
    
    XCTAssertEqual(collectionArray!.arrayValue!.count, 2)
    XCTAssertEqual(collectionArray!.arrayValue!.first!.stringValue!, "foo")
    XCTAssertEqual(collectionArray!.arrayValue!.last!.numberValue!, 42)
  }
  

  func testObjectFromString(){
    let collectionObject = JSONCollection(string:"{\"foo\": 42, \"bar\": 7}")
    XCTAssert(collectionObject != nil)
    XCTAssertTrue(collectionObject!.isObject)
    XCTAssertFalse(collectionObject!.isArray)
    
    XCTAssertEqual(collectionObject!.objectValue!.count, 2)
    XCTAssertEqual(collectionObject!.objectValue!["foo"]!.numberValue!, 42)
    XCTAssertEqual(collectionObject!.objectValue!["bar"]!.numberValue!, 7)
  }

  
  func testNestedArrayFromString(){
    let outerArray = JSONCollection(string:"[\"foo\", [1, 2, {\"a\": 42, \"thing\": 7}]]")
    XCTAssertEqual(outerArray!.arrayValue!.first!.stringValue!, "foo")
    XCTAssertEqual(outerArray!.arrayValue!.count, 2)
    
    let innerArray = outerArray!.arrayValue!.last!.collectionValue!
    XCTAssertTrue(innerArray.isArray)
    XCTAssertEqual(innerArray.arrayValue!.count, 3)
    XCTAssertEqual(innerArray.arrayValue![0].numberValue!, 1)
    XCTAssertEqual(innerArray.arrayValue![1].numberValue!, 2)
    
    let innerObject = innerArray.arrayValue!.last!.collectionValue!
    XCTAssertTrue(innerObject.isObject)
    XCTAssertEqual(innerObject.objectValue!.count, 2)
    XCTAssertEqual(innerObject.objectValue!["a"]!.numberValue!, 42)
    XCTAssertEqual(innerObject.objectValue!["thing"]!.numberValue!, 7)
  }
  

  func testNestedObjectFromString(){
    let outerObject = JSONCollection(string:"{\"foo\": {\"bar\": [1, 2, 3]}}")
    XCTAssertEqual(outerObject!.objectValue!.count, 1)
    
    let innerObject = outerObject!.objectValue!["foo"]!.collectionValue!
    XCTAssertTrue(innerObject.isObject)
    XCTAssertEqual(innerObject.objectValue!.count, 1)

    let innerArray = innerObject.objectValue!["bar"]!.collectionValue!
    XCTAssertTrue(innerArray.isArray)
    XCTAssertEqual(innerArray.arrayValue!.count, 3)
    XCTAssertEqual(innerArray.arrayValue![0].numberValue!, 1)
    XCTAssertEqual(innerArray.arrayValue![1].numberValue!, 2)
    XCTAssertEqual(innerArray.arrayValue![2].numberValue!, 3)
  }
  
  

  
  func testInitErrors(){
    var error:NSError?
    JSONCollection(string:"not JSON", error:&error)
    XCTAssertEqual(error!.code, NSPropertyListReadCorruptError)
    
    var noError:NSError?
    JSONCollection(string:"{\"is\":\"JSON\"}", error:&noError)
    XCTAssert(noError == nil)
  }

  
}
