//
//  Promise+Collections.swift
//  PromiseU
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation


extension Sequence where Iterator.Element: PromiseType {
    public typealias Value = Iterator.Element.Value

    public func onAllComplete(execute: @escaping ([Value]) -> ()) {
        allCompleted.onComplete { values in
            execute(values)
        }
    }

    public var allCompleted: Promise<[Value]> {
        return Promise<[Value]> { resolve in
            let queue = DispatchQueue(label: "[Promise<T>] -> Promise<[T]> private queue (PromiseU)")
            var result = [Value]()
            let group = DispatchGroup()
            for promise in self {
                group.enter()
                promise.onComplete(on: nil) { v in
                    queue.async {
                        result.append(v)
                        group.leave()
                    }
                }
            }

            group.notify(queue: queue) {
                resolve(result)
            }

        }
    }
}
