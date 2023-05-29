//
//  RequestController.swift
//  ImageGenerator
//
//  Created by Viktoriya on 28.05.2023.
//

import UIKit

final class RequestCounterManager {
    
    var remainingTime: TimeInterval = 0
    
    //MARK: - Private Properties

    private var requestCount: Int = 0
    private var timer: Timer?
    private var limit: Int = 5
    
    //MARK: - Run Logic

    func start(_ completion: () -> Void, exit: () -> Void) {
        requestCount += 1
        guard requestCount <= limit else {
            if timer == nil {
                startTimer()
            }
            exit()
            return
        }
        
        completion()
    }
    
    //MARK: - Private Methods

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false) { [weak self] _ in
            self?.resetRequestCount()
        }
        remainingTime = 60.0
        startCountdown()
    }
    
    private func resetRequestCount() {
        requestCount = 0
        timer = nil
    }
    
    private func startCountdown() {
        guard timer != nil else {
            return
        }
        
        DispatchQueue.global().async {
            while self.remainingTime > 0 {
                Thread.sleep(forTimeInterval: 1.0)
                self.remainingTime -= 1
                print("Requests will be restored in \(Int(self.remainingTime)) seconds...")
            }
        }
    }
}
