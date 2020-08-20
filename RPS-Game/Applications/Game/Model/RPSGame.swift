//
//  RPSGame.swift
//  RPS-Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

import Foundation

struct RPSGame {
    
    // MARK: Properties
    private(set) var computerChooseItem: GameView.Item?
    private(set) var playerChooseItem: GameView.Item?
    var round: Int = 0
}

// MARK: Methods
extension RPSGame {
    
    mutating func startGame(with item: GameView.Item) {
        playerChooseItem = item
        computerChooseItem = GameView.Item.allCases.randomElement()
    }
    
    mutating func resetGame() {
        self = RPSGame()
    }
    
    func checkState() -> State {
        guard let playerItem = playerChooseItem,
            let computerItem = computerChooseItem else {
                return .none
        }
        
        switch (playerItem, computerItem) {
        case (.rock, .scissor), (.scissor, .paper), (.paper, .rock):
            return .win
        case (.paper, .scissor), (.rock, .paper), (.scissor, .rock):
            return .lose
        default:
            return .draw
        }
    }
}

// MARK: Nested Types
extension RPSGame {
    
    enum State {
        case win, draw, lose, none
    }
}

