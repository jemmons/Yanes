import Foundation

extension JSON : CollectionType{
  public var startIndex:Int{
    //Always 0 for all types.
    return 0
  }

  
  public var endIndex:Int{
    switch self{
    case .Array(let array):
      return array.endIndex
    case .Object(let object):
      return object.count
    case .String:
      return 1
    case .Number:
      return 1
    case .Null:
      return 0
    }
  }

  public subscript(index:Int) -> JSON{
    get{
      switch self{
      case .Array(let array):
        return array[index]
      case .Object(let object):
        let objectIndex = object.nthIndex(index)
        return object[objectIndex].1
      case .String:
        return self
      case .Number:
        return self
      case .Null:
        fatalError("Null JSON value should never be iterated over.")
      }
    }
    set{
      guard case .Array(var array) = self else{
        fatalError("Attempted to set non-array value by index. This would be non-deterministic at best.")
      }
      array[index] = newValue
      self = JSON.Array(array)
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

