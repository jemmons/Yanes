//
//  JSONMutableDictionaryTests.swift
//  Yanes
//
//  Created by Joshua Emmons on 11/27/15.
//  Copyright © 2015 MCMXCIX. All rights reserved.
//

import Foundation
import XCTest
import Yanes

class JSONMutableDictionaryTests : XCTestCase{
  func testAppendDictionaryValue(){
    var subject = JSON.Object(["foo":JSON.Number(42)])
    let replaced = subject.updateValue(JSON.Number(64), forKey:"bar")
    XCTAssertEqual(subject.objectValue!, ["foo":JSON.Number(42), "bar":JSON.Number(64)])
    XCTAssert(replaced == nil)
  }
  
  
  func testAppendValueAtDictionarySubscript(){
    var subject = JSON.Object(["foo":JSON.Number(42)])
    subject["bar"] = JSON.Number(64)
    XCTAssertEqual(subject.objectValue!, ["foo":JSON.Number(42), "bar":JSON.Number(64)])
  }
  
  
  func testReplaceDictionaryValue(){
    var subject = JSON.Object(["foo":JSON.Number(42)])
    let replaced = subject.updateValue(JSON.Number(64), forKey:"foo")
    XCTAssertEqual(subject.objectValue!, ["foo":JSON.Number(64)])
    XCTAssert(replaced == 42)
  }
  
  
  func testReplaceValueAtDictionarySubscript(){
    var subject = JSON.Object(["foo":JSON.Number(42)])
    subject["foo"] = JSON.Number(64)
    XCTAssertEqual(subject.objectValue!, ["foo":JSON.Number(64)])
  }
  
  
  func testRemoveDictionary(){
    var subject = JSON.Object(["foo":JSON.Number(42)])
    subject.removeValueForKey("foo")
    XCTAssertEqual(subject.objectValue!, JSONObject())
  }
  
  
  func testMutateDictionaryAtArraySubscript(){
    var subject = JSON.Array([JSON.Object(["key":JSON.Number(42)])])
    subject[0].updateValue(JSON.Number(64), forKey: "key")
    XCTAssertEqual(subject.arrayValue!, [JSON.Object(["key":JSON.Number(64)])])
  }
}


