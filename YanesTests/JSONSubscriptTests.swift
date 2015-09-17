import Foundation
import XCTest
import Yanes

class JSONSubscriptTests : XCTestCase{
//  func testArraySubscript(){
//    let subject = try! JSON.parseArray([1,2,3])
//    XCTAssertEqual(subject[0]!.numberValue!, 1)
//    XCTAssertEqual(subject[1]!.numberValue!, 2)
//    XCTAssertEqual(subject[2]!.numberValue!, 3)
//    XCTAssert(subject[3] == nil)
//  }
  
  
  //  func testObjectSubscript(){
  //    let subject = JSONCollection(dictionary: ["one":1, "two":2, "three":3])!
  //    XCTAssertEqual(subject["one"]!.numberValue!, 1)
  //    XCTAssertEqual(subject["two"]!.numberValue!, 2)
  //    XCTAssertEqual(subject["three"]!.numberValue!, 3)
  //    XCTAssert(subject["foo"] == nil)
  //  }
  //
  //  func testJSONSubscript(){
  //    let jsonObject = JSONCollection(dictionary: ["one":1, "two":2, "three":3])!
  //    XCTAssertEqual(jsonObject[JSONSubscript.Key("one")]!.numberValue!, 1)
  //    XCTAssertEqual(jsonObject[JSONSubscript.Key("two")]!.numberValue!, 2)
  //    XCTAssertEqual(jsonObject[JSONSubscript.Key("three")]!.numberValue!, 3)
  //
  //    let jsonArray = JSONCollection(array:[1,2,3])!
  //    XCTAssertEqual(jsonArray[JSONSubscript.Index(0)]!.numberValue!, 1)
  //    XCTAssertEqual(jsonArray[JSONSubscript.Index(1)]!.numberValue!, 2)
  //    XCTAssertEqual(jsonArray[JSONSubscript.Index(2)]!.numberValue!, 3)
  //
  //    let mix:NSDictionary = ["numbers":[1,2,3], "letters":["a":"ay", "b":"bee", "c":["see", "cee"]]]
  //    let jsonMix = JSONCollection(dictionary:mix)!
  //    XCTAssertEqual(jsonMix["numbers", 0]!.numberValue!, 1)
  //    XCTAssertEqual(jsonMix["letters", "a"]!.stringValue!, "ay")
  //    XCTAssertEqual(jsonMix["letters", "c", 1]!.stringValue!, "cee")
  //    XCTAssert(jsonMix["numbers", 3] == nil)
  //    XCTAssert(jsonMix["letters", "foo"] == nil)
  //    XCTAssert(jsonMix["letters", "a", "nothing"] == nil)
  //  }
  //
  //  func testJSONExample(){//from http://json.org/example
  //    let rawJSON = "{ \"glossary\": { \"title\": \"example glossary\", \"GlossDiv\": { \"title\": \"S\", \"GlossList\": { \"GlossEntry\": { \"ID\": \"SGML\", \"SortAs\": \"SGML\", \"GlossTerm\": \"Standard Generalized Markup Language\", \"Acronym\": \"SGML\", \"Abbrev\": \"ISO 8879:1986\", \"GlossDef\": { \"para\": \"A meta-markup language, used to create markup languages such as DocBook.\", \"GlossSeeAlso\": [\"GML\", \"XML\"] }, \"GlossSee\": \"markup\" } } } } }"
  //    let subject = JSONCollection(string: rawJSON)!
  //    XCTAssertEqual(subject["glossary", "title"]!.stringValue!, "example glossary")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "title"]!.stringValue!, "S")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "Abbrev"]!.stringValue!, "ISO 8879:1986")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "Acronym"]!.stringValue!, "SGML")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "GlossSee"]!.stringValue!, "markup")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "GlossTerm"]!.stringValue!, "Standard Generalized Markup Language")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "ID"]!.stringValue!, "SGML")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "SortAs"]!.stringValue!, "SGML")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "GlossDef", "GlossSeeAlso", 0]!.stringValue!, "GML")
  //    XCTAssertEqual(subject["glossary", "GlossDiv", "GlossList", "GlossEntry", "GlossDef", "GlossSeeAlso", 1]!.stringValue!, "XML")
  //
  //  }

}