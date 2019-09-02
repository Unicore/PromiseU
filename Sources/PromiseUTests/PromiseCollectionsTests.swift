//
//  PromiseCollectionsTests.swift
//  PromiseU iOS Tests
//
//  Created by Maxim Bazarov on 4/13/18.
//  Copyright © 2018 Functional Swift. All rights reserved.
//

import XCTest
@testable import PromiseU

class PromiseCollectionsTests: XCTestCase {

    func testCollectionOfPromise_AllWithSameDelayBeforeResolving_shouldCallOnCompleteAfterDelay() {
        let exp = expectation(description: "resolved promise")
        let count = 100
        let sut = [Int].init(repeating: 1, count: count)

        sut.map(promise2sDelay).onAllComplete { values in
            if values.count == count { exp.fulfill() }
        }

        wait(for: [exp], timeout: delay + maxDeviation)
    }


    // MARK: - Utils
    
    
    let maxDeviation: Double = 0.15
    let delay: Double = 1 // 1 sec
    func promise2sDelay(_ v: Int) -> Promise<Int> {
        return Promise<Int> { resolve in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                resolve(v)
            }
        }
    }
    


   

}
