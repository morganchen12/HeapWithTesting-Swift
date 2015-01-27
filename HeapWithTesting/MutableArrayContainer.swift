//
//  MutableArrayContainer.swift
//  HeapWithTesting
//
//  Created by Morgan Chen on 1/26/15.
//  Copyright (c) 2015 Morgan Chen. All rights reserved.
//

import Foundation

class MutableArrayContainer {
    var array: Array<Int>
    
    init() {
        array = [Int]()
    }
    
    class func randomArrayWithLength(length: Int) -> MutableArrayContainer {
        
        var arrayContainer = MutableArrayContainer()
        for var i = 0; i < length; i++ {
            arrayContainer.array.append(Int(arc4random() % (length+1)))
        }
        
        return arrayContainer
    }
    
    func sortWithHeapSort() {
        
    }
    
    func heapify() {
        
    }
}
