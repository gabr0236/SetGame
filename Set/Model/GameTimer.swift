//
//  GameTimer.swift
//  Set
//
//  Created by Gabriel Haugbøl on 10/11/2021.
//

import Foundation

class GameTimer {
    private(set) var secondsElapsed = 0
    private(set) var state = GameTimerState.stopped
    private var timer = Timer()
    
    func restart() {
        secondsElapsed = 0
        state = GameTimerState.running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.secondsElapsed += 1
        }
    }
    
    func start() {
        state = GameTimerState.running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.secondsElapsed += 1
        }
    }
    
    func pause() {
        timer.invalidate()
        state = GameTimerState.paused
    }
    
    func reset() {
            timer.invalidate()
            secondsElapsed = 0
        state = GameTimerState.stopped
    }
}

enum GameTimerState {
    case running, stopped, paused
}
