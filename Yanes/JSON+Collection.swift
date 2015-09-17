import Foundation

extension JSON : CollectionType{
  public var startIndex:Int{
    //Always 0 for all types.
    return 0
  }

  
  public var endIndex:Int{
    switch self{
    case .ArrayValue(let array):
      return array.endIndex
    case .ObjectValue(let object):
      return object.count
    case .StringValue:
      return 1
    case .NumberValue:
      return 1
    case .NullValue:
      return 0
    }
  }

  public subscript(index:Int) -> JSON{
    switch self{
    case .ArrayValue(let array):
      return array[index]
    case .ObjectValue(let object):
      let objectIndex = object.nthIndex(index)
      return object[objectIndex].1
    case .StringValue:
      return self
    case .NumberValue:
      return self
    case .NullValue:
      fatalError("Null JSON value should never be iterated over.")
    }
  }
}


private extension Dictionary{
  func nthIndex(n:Int) -> Index{
    guard n < count else{
      fatalError("Index \(n) beyond bounds of Dictionary.")
    }
    var index = startIndex
    for _ in 0..<n{
      index = index.successor()
    }
    return index
  }
}

