import Foundation
import XCTest
import Yanes

class JSONIndexTests : XCTestCase{
  func testArrayIndex(){
    let subject = try! JSON.parseArray([1,2,3])
    let one = 0
    let two = 1
    let three = 2
    XCTAssertEqual(subject[one].numberValue!, 1)
    XCTAssertEqual(subject[two].numberValue!, 2)
    XCTAssertEqual(subject[three].numberValue!, 3)
  }
  
  
  func testArrayLiteralIndex(){
    let subject = try! JSON.parseArray([1,2,3])
    XCTAssertEqual(subject[0]!.numberValue!, 1)
    XCTAssertEqual(subject[1]!.numberValue!, 2)
    XCTAssertEqual(subject[2]!.numberValue!, 3)
  }
  
  
  func testObjectIndex(){
    let subject = try! JSON.parseDictionary(["one":1, "two":2, "three":3])
    let one = "one"
    let two = "two"
    let three = "three"
    let foo = "foo"
    XCTAssertEqual(subject[one]!.numberValue!, 1)
    XCTAssertEqual(subject[two]!.numberValue!, 2)
    XCTAssertEqual(subject[three]!.numberValue!, 3)
    XCTAssert(subject[foo] == nil)
  }
  
  
  func testObjectLiteralIndex(){
    let subject = try! JSON.parseDictionary(["one":1, "two":2, "three":3])
    XCTAssertEqual(subject["one"]!.numberValue!, 1)
    XCTAssertEqual(subject["two"]!.numberValue!, 2)
    XCTAssertEqual(subject["three"]!.numberValue!, 3)
    XCTAssert(subject["foo"] == nil)
  }

  
  func testJSONIndex(){
    let jsonObject = try! JSON.parseDictionary(["one":1, "two":2, "three":3])
    XCTAssertEqual(jsonObject[JSONIndex.Key("one")]!.numberValue!, 1)
    XCTAssertEqual(jsonObject[JSONIndex.Key("two")]!.numberValue!, 2)
    XCTAssertEqual(jsonObject[JSONIndex.Key("three")]!.numberValue!, 3)
    
    let jsonArray = try! JSON.parseArray([1,2,3])
    XCTAssertEqual(jsonArray[JSONIndex.Index(0)]!.numberValue!, 1)
    XCTAssertEqual(jsonArray[JSONIndex.Index(1)]!.numberValue!, 2)
    XCTAssertEqual(jsonArray[JSONIndex.Index(2)]!.numberValue!, 3)
  }
  
  
  func testJSONIndexEquatable(){
    XCTAssertEqual(JSONIndex.Key("key"), JSONIndex.Key("key"))
    XCTAssertEqual(JSONIndex.Index(42), JSONIndex.Index(42))
    XCTAssertNotEqual(JSONIndex.Key("key"), JSONIndex.Index(42))
    XCTAssertNotEqual(JSONIndex.Index(42),JSONIndex.Key("key"))
    XCTAssertNotEqual(JSONIndex.Key("foo"), JSONIndex.Key("bar"))
    XCTAssertNotEqual(JSONIndex.Index(41), JSONIndex.Index(42))
  }
  
  
  func testJSONIndexConvertible(){
    let arrayIndex:JSONIndex = 42
    XCTAssertEqual(arrayIndex, JSONIndex.Index(42))

    let objectIndex:JSONIndex = "key"
    XCTAssertEqual(objectIndex, JSONIndex.Key("key"))
  }
  
  
  func testIndexPath(){
    let mix = ["numbers":[1,2,3], "letters":["a":"ay", "b":"bee", "c":["see", "cee"]]]
    let jsonMix = try! JSON.parseDictionary(mix)
    XCTAssertEqual(jsonMix["numbers", 0]!.numberValue!, 1)
    XCTAssertEqual(jsonMix["letters", "a"]!.stringValue!, "ay")
    XCTAssertEqual(jsonMix["letters", "c", 1]!.stringValue!, "cee")
    XCTAssert(jsonMix["letters", "foo"] == nil)
    XCTAssert(jsonMix["letters", "a", "nothing"] == nil)
  }
  
  
  func testJSONIndexPolymorphicInit(){
    let arrayIndex = JSONIndex(42)
    XCTAssertEqual(arrayIndex, JSONIndex.Index(42))
    
    let objectIndex = JSONIndex("key")
    XCTAssertEqual(objectIndex, JSONIndex.Key("key"))
  }
  
  
  func testJSONExample(){//from http://json.org/example
    let rawJSON = "{ \"glossary\": { \"title\": \"example glossary\", \"GlossDiv\": { \"title\": \"S\", \"GlossList\": { \"GlossEntry\": { \"ID\": \"SGML\", \"SortAs\": \"SGML\", \"GlossTerm\": \"Standard Generalized Markup Language\", \"Acronym\": \"SGML\", \"Abbrev\": \"ISO 8879:1986\", \"GlossDef\": { \"para\": \"A meta-markup language, used to create markup languages such as DocBook.\", \"GlossSeeAlso\": [\"GML\", \"XML\"] }, \"GlossSee\": \"markup\" } } } } }"
    let subject = try! JSON.parseString(rawJSON)
    XCTAssertEqual(subject["glossary", "title"]!.stringValue!, "example glossary")
    XCTAssertEqual(subject["glossary", "GlossDiv", "title"]!.stringValue!, "S")
    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "Abbrev"]!.stringValue!, "ISO 8879:1986")
    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "Acronym"]!.stringValue!, "SGML")
    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "GlossSee"]!.stringValue!, "markup")
    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "GlossTerm"]!.stringValue!, "Standard Generalized Markup Language")
    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "ID"]!.stringValue!, "SGML")
    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "SortAs"]!.stringValue!, "SGML")
    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "GlossDef", "GlossSeeAlso", 0]!.stringValue!, "GML")
    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "GlossDef", "GlossSeeAlso", 1]!.stringValue!, "XML")
    
  }

}