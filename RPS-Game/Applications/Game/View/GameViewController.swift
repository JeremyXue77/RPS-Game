//
//  GameViewController.swift
//  RPS-Game
//
//  Created by Jeremy Xue on 2020/8/19.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

import UIKit
import Combine

class GameViewController: UIViewController {
    
    // MARK: Properties
    private var gameView: GameView? {
        view as? GameView
    }
    
    private var gameViewModel: GameViewModel?
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupViewModel()
        setupGameView()
    }
    
    // MARK: Setting Methods
    private func setupNavigationItems() {
        navigationItem.title = "RPS Game"
        let resetButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                          target: self,
                                          action: #selector(touchOnResetButton(_:)))
        navigationItem.leftBarButtonItem = resetButton
    }
    
    private func setupGameView() {
        gameView?.delegate = self
    }
    
    private func setupViewModel() {
        let game = RPSGame()
        gameViewModel = GameViewModel(game: game)
        guard let gameView = gameView else { return }
        gameViewModel?.$message
            .assign(to: \.messageLabel.text, on: gameView)
            .store(in: &subscriptions)
        gameViewModel?.$computerItemEmoji
            .assign(to: \.computerChooseItemLabel.text, on: gameView)
            .store(in: &subscriptions)
        gameViewModel?.$playerItemEmoji
            .assign(to: \.playerChooseItemLabel.text, on: gameView)
            .store(in: &subscriptions)
        gameViewModel?.$roundTitle
            .assign(to: \.roundLabel.text, on: gameView)
            .store(in: &subscriptions)
    }
    
    // MARK: Features
    @objc private func touchOnResetButton(_ sender: UIBarButtonItem) {
        gameViewModel?.reset()
    }
}

// MARK: - GameViewController + GameViewDelegate
extension GameViewController: GameViewDelegate {
    
    func gameView(_ gameView: GameView, didChooseItem item: GameView.Item) {
        gameViewModel?.startGame(with: item)
    }
}
