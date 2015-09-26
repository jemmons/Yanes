import UIKit
import XCTest
import Yanes


class JSONParseTests: XCTestCase {
  func testParseNumberArray(){
    let intArray = try! JSON.parseArray([1,2,3])
    XCTAssert(intArray.isArray)
    XCTAssertEqual(intArray.arrayValue!, [JSON.Number(1), JSON.Number(2), JSON.Number(3)])

  }
  
  
  func testParseStringArray(){
    let stringArray = try! JSON.parseArray(["foo", "bar", "baz"])
    XCTAssert(stringArray.isArray)
    XCTAssertEqual(stringArray.arrayValue!, [JSON.String("foo"), JSON.String("bar"), JSON.String("baz")])
  }
  
  
  func testParseMixedArray(){
    let mixedArray = try! JSON.parseArray([1, "bar", [1,2,3]])
    XCTAssert(mixedArray.isArray)
    let manualArray = [
      JSON.Number(1),
      JSON.String("bar"),
      JSON.Array([JSON.Number(1), JSON.Number(2), JSON.Number(3)])
    ]
    XCTAssertEqual(mixedArray.arrayValue!, manualArray)
  }
  
  
  func testParseInvalidArray(){
    do{
      let _ = try JSON.parseArray([NSDate()])
      XCTFail()
    }catch ParseError.InvalidValue{
      XCTAssert(true)
    }catch{
      XCTFail()
    }
  }
  
  
  func testParseNumberDictionary(){
    let intAnswer = [
      "foo":JSON.Number(1),
      "bar":JSON.Number(2),
      "baz":JSON.Number(3)
    ]
    let intObject = try! JSON.parseDictionary(["foo":1, "bar":2, "baz":3])
    XCTAssert(intObject.isObject)
    XCTAssertEqual(intObject.objectValue!, intAnswer)
  }
  
  
  func testParseStringDictionary(){
    let stringAnswer = [
      "foo":JSON.String("one"),
      "bar":JSON.String("two"),
      "baz":JSON.String("three")
    ]
    let stringObject = try! JSON.parseDictionary(["foo":"one", "bar":"two", "baz":"three"])
    XCTAssert(stringObject.isObject)
    XCTAssertEqual(stringObject.objectValue!, stringAnswer)
  }
  
  
  func testParseMixedDictionary(){
    let mixedAnswer = [
      "foo":JSON.Number(1),
      "bar":JSON.String("two"),
      "baz":JSON.Array([JSON.Number(1), JSON.Number(2), JSON.Number(3)])
    ]

    let mixedObject = try! JSON.parseDictionary(["foo":1, "bar":"two", "baz":[1,2,3]])
    XCTAssert(mixedObject.isObject)
    XCTAssertEqual(mixedObject.objectValue!, mixedAnswer)
  }

  
  func testParseDictionaryWithInvalidKey(){
    do{
      let _ = try JSON.parseDictionary([1:"One"])
      XCTFail()
    } catch ParseError.InvalidKey{
      XCTAssert(true)
    } catch{
      XCTFail()
    }
  }

  
  func testParseDictionaryWithInvalidValue(){
    do{
      let _ = try JSON.parseDictionary(["foo":NSDate()])
      XCTFail()
    } catch ParseError.InvalidValue{
      XCTAssert(true)
    } catch{
      XCTFail()
    }
  }
  
  
  func testParseArrayString(){
    let jsonArray = try! JSON.parseString("[\"foo\", 42]")
    XCTAssertTrue(jsonArray.isArray)
    XCTAssertFalse(jsonArray.isObject)
    
    XCTAssertEqual(jsonArray.arrayValue!.count, 2)
    XCTAssertEqual(jsonArray.arrayValue!.first!.stringValue!, "foo")
    XCTAssertEqual(jsonArray.arrayValue!.last!.numberValue!, 42)
  }


  func testParseObjectString(){
    let jsonObject = try! JSON.parseString("{\"foo\": 42, \"bar\": 7}")
    XCTAssertTrue(jsonObject.isObject)
    XCTAssertFalse(jsonObject.isArray)
    
    XCTAssertEqual(jsonObject.objectValue!.count, 2)
    XCTAssertEqual(jsonObject.objectValue!["foo"]!.numberValue!, 42)
    XCTAssertEqual(jsonObject.objectValue!["bar"]!.numberValue!, 7)
  }

  
  func testParseNestedArrayString(){
    let outerArray = try! JSON.parseString("[\"foo\", [1, 2, {\"a\": 42, \"thing\": 7}]]")
    XCTAssertEqual(outerArray.arrayValue!.first!.stringValue!, "foo")
    XCTAssertEqual(outerArray.arrayValue!.count, 2)
    
    let innerArray = outerArray.arrayValue!.last!
    XCTAssertTrue(innerArray.isArray)
    XCTAssertEqual(innerArray.arrayValue!.count, 3)
    XCTAssertEqual(innerArray.arrayValue![0].numberValue!, 1)
    XCTAssertEqual(innerArray.arrayValue![1].numberValue!, 2)
    
    let innerObject = innerArray.arrayValue!.last!
    XCTAssertTrue(innerObject.isObject)
    XCTAssertEqual(innerObject.objectValue!.count, 2)
    XCTAssertEqual(innerObject.objectValue!["a"]!.numberValue!, 42)
    XCTAssertEqual(innerObject.objectValue!["thing"]!.numberValue!, 7)
  }


  func testParseNestedObjectString(){
    let outerObject = try! JSON.parseString("{\"foo\": {\"bar\": [1, 2, 3]}}")
    XCTAssertEqual(outerObject.objectValue!.count, 1)
    
    let innerObject = outerObject.objectValue!["foo"]!
    XCTAssertTrue(innerObject.isObject)
    XCTAssertEqual(innerObject.objectValue!.count, 1)

    let innerArray = innerObject.objectValue!["bar"]!
    XCTAssertTrue(innerArray.isArray)
    XCTAssertEqual(innerArray.arrayValue!.count, 3)
    XCTAssertEqual(innerArray.arrayValue![0].numberValue!, 1)
    XCTAssertEqual(innerArray.arrayValue![1].numberValue!, 2)
    XCTAssertEqual(innerArray.arrayValue![2].numberValue!, 3)
  }

  
  func testParseInvalidString(){
    do{
      try JSON.parseString("not json")
      XCTFail()
    } catch{
      XCTAssert(true)
    }
  }
}

