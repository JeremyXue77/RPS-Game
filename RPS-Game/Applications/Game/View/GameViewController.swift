//
//  GameViewController.swift
//  RPS-Game
//
//  Created by Jeremy Xue on 2020/8/19.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: Properties
    private var gameView: GameView? {
        view as? GameView
    }
    
    private var gameViewModel: GameViewModel?

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
        gameViewModel?.$message.bind { [weak gameView](msg) in
            gameView?.messageLabel.text = msg
        }
        gameViewModel?.$computerItemEmoji.bind{ [weak gameView](emoji) in
            gameView?.computerChooseItemLabel.text = emoji
        }
        gameViewModel?.$playerItemEmoji.bind{ [weak gameView](emoji) in
            gameView?.playerChooseItemLabel.text = emoji
        }
        gameViewModel?.$roundTitle.bind { [weak gameView](title) in
            gameView?.roundLabel.text = title
        }
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
