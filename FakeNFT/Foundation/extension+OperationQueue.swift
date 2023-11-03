//
//  extension+OperationQueue.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import Foundation

extension OperationQueue {
    func addOperation(_ block: @escaping () -> Void, withDelay: TimeInterval) {
        let delayOperation = BlockOperation {
            Thread.sleep(forTimeInterval: withDelay)
        }
        self.addOperation(block)
        self.addOperation(delayOperation)
    }
}
