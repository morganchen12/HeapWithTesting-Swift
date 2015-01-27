//
//  HeapWithTestingTests.swift
//  HeapWithTestingTests
//
//  Created by Morgan Chen on 1/26/15.
//  Copyright (c) 2015 Morgan Chen. All rights reserved.
//

import UIKit
import XCTest
import HeapWithTesting

// constant to determine the length of each array for testing
let kNumberOfElementsInArray = 1000

class HeapWithTestingTests: XCTestCase {
    
    var arrayContainer: MutableArrayContainer = MutableArrayContainer()
    
    override func setUp() {
        super.setUp()
        self.arrayContainer = MutableArrayContainer.randomArrayWithLength(kNumberOfElementsInArray)
    }
    
    func testHeapifyDidSucceed() {
        //MARK: Heapify test assumes a max heap. If you use a min heap, you must modify this test.
        
        // heapify
        self.measureBlock() {
            self.arrayContainer.heapify()
        }
        
        var heapIsValid = true
        let array = self.arrayContainer.array
        
        // check that max heap status is maintained
        for var i = 0; i < array.count; i++ {
            
            // assign pointers
            let node = array[i]
            let leftChildIndex = 2*i + 1
            let rightChildIndex = 2*i + 2
            var leftChild = NSNotFound
            var rightChild = NSNotFound
            
            // only assign left and right children if they exist
            if leftChildIndex < array.count { leftChild = array[leftChildIndex] }
            if rightChildIndex < array.count {rightChild = array[rightChildIndex] }
            
            // check that heap status is maintained in node's children
            if leftChild != NSNotFound && leftChild > node {
                heapIsValid = false
                break
            }
            if rightChild != NSNotFound && rightChild > node {
                heapIsValid = false
                break
            }
        }
        
        XCTAssert(heapIsValid, "Heapify does not work. Send help")
    }
    
    func testSortDidSucceed() {
        
        // create reference array, sort with native sort function
        var referenceArray = self.arrayContainer.array
        referenceArray.sort( { $0 < $1 } )
        
        // sort using heapsort
        self.measureBlock {
            self.arrayContainer.sortWithHeapSort()
        }
        
        // compare
        XCTAssert(self.arrayContainer.array == referenceArray, "HEAPSORT is ALL WRONG!!! OH NO...!!!!!")
    }
}
