import UIKit
import XCTest
import Yanes

class JSONCollectionTests: XCTestCase {
  func testObjectFromString(){
    let collectionObject = JSONCollection(string:"{\"foo\":\"bar\"}")
    XCTAssert(collectionObject != nil)
    XCTAssertTrue(collectionObject!.isObject)
    XCTAssertFalse(collectionObject!.isArray)
    
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
  
  
  func testNestedArrayFromString(){
    let outerArray = JSONCollection(string:"[\"foo\", [1,2, [\"a\", 42, \"thing\"]]]")
    XCTAssertEqual(outerArray!.arrayValue!.first!.stringValue!, "foo")
    XCTAssertEqual(outerArray!.arrayValue!.count, 2)
    
    let innerArray = outerArray!.arrayValue!.last!.collectionValue!
    XCTAssertTrue(innerArray.isArray)
    XCTAssertEqual(innerArray.arrayValue!.count, 3)
    XCTAssertEqual(innerArray.arrayValue![0].numberValue!, 1)
    XCTAssertEqual(innerArray.arrayValue![1].numberValue!, 2)
    
    let innerInnerArray = innerArray.arrayValue!.last!.collectionValue!
    XCTAssertTrue(innerInnerArray.isArray)
    XCTAssertEqual(innerInnerArray.arrayValue!.count, 3)
    XCTAssertEqual(innerInnerArray.arrayValue![0].stringValue!, "a")
    XCTAssertEqual(innerInnerArray.arrayValue![1].numberValue!, 42)
    XCTAssertEqual(innerInnerArray.arrayValue![2].stringValue!, "thing")
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
