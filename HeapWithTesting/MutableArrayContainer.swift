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
    
    func swapObjectAtIndex(index1: Int, withIndex index2: Int) {
        let objectAtIndex1 = self.array[index1]
        self.array[index1] = self.array[index2]
        self.array[index2] = objectAtIndex1
    }
    
    func sortWithHeapSort() {
        
        // use heapEnd to separate heap part of array and sorted part of array
        // sort by pulling root of max heap and swapping it to the back of array,
        // then reheapify after swap
        var heapEnd = self.array.count - 1
        
        // degenerate case
        if self.array.count <= 1 { return }
        
        // initially heapify entire array
        self.heapify()
        
        while heapEnd > 0 {
            
            // place root of max heap at end of array and decrement heapEnd
            self.swapObjectAtIndex(0, withIndex: heapEnd)
            heapEnd--
            
            var nodeIndex = 0
            var leftChildIndex = 2*nodeIndex + 1
            var rightChildIndex = 2*nodeIndex + 2
            
            // reheapify iteratively
            while nodeIndex <= heapEnd {
                
                var leftChildExists = (leftChildIndex <= heapEnd)
                var rightChildExists = (rightChildIndex <= heapEnd)
                
                var node = self.array[nodeIndex]
                var leftChild = NSNotFound
                var rightChild = NSNotFound
                
                // assign left and right children properly if they exist
                if leftChildExists { leftChild = self.array[leftChildIndex] }
                if rightChildExists { rightChild = self.array[rightChildIndex] }
                
                var largestChild = NSNotFound
                var largestChildIndex = NSNotFound
                
                // if no children, exit loop
                if !leftChildExists && !rightChildExists {
                    break
                }
                
                // determine largest child
                // consider 2 cases: one child exists or both exist
                // if only one child exists, it must be the left child
                // because tree is always left-heavy
                
                // handle single child case
                if !rightChildExists {
                    largestChild = leftChild
                    largestChildIndex = leftChildIndex
                }
                    
                // handle both children case, compare and pick largest
                else {
                    let isLeftChildBigger = (leftChild >= rightChild)
                    largestChild = isLeftChildBigger ? leftChild : rightChild
                    largestChildIndex = isLeftChildBigger ? leftChildIndex : rightChildIndex
                }
                
                // compare node with largest child and swap if necessary to maintain max heap property
                if node < largestChild {
                    self.swapObjectAtIndex(nodeIndex, withIndex: largestChildIndex)
                    
                    // reassign pointers
                    nodeIndex = largestChildIndex
                    leftChildIndex = 2*nodeIndex + 1
                    rightChildIndex = 2*nodeIndex + 2
                }
                
                // if no swap is possible, heap is in order and we can exit loop
                else {
                    break
                }
            }
        }
    }
    
    func heapify() {
        // produce max heap
        
        for var i = 0; i < self.array.count; i++ {
            
            var nodeIndex = i
            var parentIndex = (i - 1)/2
            
            var parent = self.array[parentIndex]
            var node = self.array[nodeIndex]
            
            // check parent as long as node is not root
            while nodeIndex != parentIndex {
                
                // if parent is less than child, swap to maintain max heap status
                if parent < node {
                    self.swapObjectAtIndex(nodeIndex, withIndex: parentIndex)
                }
                else {
                    break
                }
                
                // reassign pointers
                nodeIndex = parentIndex
                parentIndex = (nodeIndex - 1)/2
                
                parent = self.array[parentIndex]
                node = self.array[nodeIndex]
            }
        }
    }
}
