//
//  GameViewModel.swift
//  RPS-Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

import Foundation
import Combine

class GameViewModel {
    
    // MARK: Properites
    private var game: RPSGame {
        didSet {
            updateBoxProperties()
        }
    }
    
    // MARK: Initializer
    init(game: RPSGame) {
        self.game = game
    }
    
    // MARK: Box Properties
    @Published var message:String? = "😎 Please choose an Item"
    @Published var playerItemEmoji:String? = "❓"
    @Published var computerItemEmoji:String? = "❓"
    @Published var roundTitle:String? = "Waiting..."
    
    // MARK: Features
    private func updateBoxProperties() {
        playerItemEmoji = covertItemToEmoji(game.playerChooseItem)
        computerItemEmoji = covertItemToEmoji(game.computerChooseItem)
        message = convertStateToMessgae(game.checkState())
        if game.round == 0 {
            roundTitle = "Waiting..."
        } else {
            roundTitle = "Round \(game.round)"
        }
    }
    
    private func convertStateToMessgae(_ state: RPSGame.State) -> String {
        switch state {
        case .win:  return "🎉 You win!!"
        case .lose: return "🤢 You lose!!"
        case .draw: return "🤝 Draw!!"
        case .none: return "😎 Please choose an Item"
        }
    }
    
    private func covertItemToEmoji(_ item: GameView.Item?) -> String {
        switch item {
        case .paper:   return "✋🏻"
        case .scissor: return "✌🏻"
        case .rock:    return "✊🏻"
        default:       return "❓"
        }
    }
}

// MARK: - Methods
extension GameViewModel {
    
    func startGame(with item: GameView.Item) {
        game.round += 1
        game.startGame(with: item)
    }
    
    func reset() {
        game.resetGame()
    }
}
