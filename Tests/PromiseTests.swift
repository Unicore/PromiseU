//
//  PromiseTests.swift
//  PromiseU
//
//  Created by Maxim Bazarov on 4/13/18.
//  Copyright © 2018 Functional Swift. All rights reserved.
//

import XCTest
@testable import PromiseU


class PromiseTests: XCTestCase {
    
    func testPromise_withDelayBeforeResolving_shouldCallOnCompleteAfterDelay() {
        let exp = expectation(description: "resolved promise")
        let sut = promise2sDelay()
        sut.onComplete { _ in exp.fulfill() }
        wait(for: [exp], timeout: delay + maxDeviation)
    }

    func testPromise_F1_thenF2_BothWithSameDelayBeforeResolving_shouldCallOnCompleteAfterDelayX2() {
        let exp = expectation(description: "resolved promise")
        let sut = promise2sDelay().then(promise2sDelay)
        sut.onComplete {_ in 
            exp.fulfill()
        }
        wait(for: [exp], timeout: delay * 2 + maxDeviation)
    }



    func testPromise_F1_AndF2_AndF3_AllWithSameDelayBeforeResolving_shouldCallOnCompleteAfterDelay() {
        let exp = expectation(description: "resolved promise")
        let sut = promise2sDelay()
            .and(promise2sDelay())
            .and(promise2sDelay())
        sut.onComplete { _, _ in
            exp.fulfill()
        }
        wait(for: [exp], timeout: delay + maxDeviation)
    }

    // MARK: - Utils
    let maxDeviation: Double = 0.15
    let delay: Double = 2 // 2 sec
    
    func promise2sDelay(value: Int = 1) -> Promise<Int> {
        
        let ptq = DispatchQueue(label: "com.test.private-queue")
        return Promise<Int> { resolve in
            ptq.asyncAfter(deadline: .now() + delay) {
                print("-> + resolved \(value)")
                resolve(value)
            }
        }
    }
    
    // MARK: Await
    
    func testPromise_withDelayBeforeResolving_shouldAwaitAndReturnTheResult() {
        let sut = promise2sDelay(value: 7)
        let result = sut.await()
        XCTAssertEqual(result, 7)
    }

    
}
