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
    private var bindJobs:Array<Cancelable> = []
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
        gameViewModel?.message.bind { (msg) in
            self.gameView?.messageLabel.text = msg
        }.store(&bindJobs)
        gameViewModel?.computerItemEmoji.bind{ (emoji) in
            self.gameView?.computerChooseItemLabel.text = emoji
        }.store(&bindJobs)
        gameViewModel?.playerItemEmoji.bind{ (emoji) in
            self.gameView?.playerChooseItemLabel.text = emoji
        }.store(&bindJobs)
        gameViewModel?.roundTitle.bind { (title) in
            self.gameView?.roundLabel.text = title
        }.store(&bindJobs)
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
