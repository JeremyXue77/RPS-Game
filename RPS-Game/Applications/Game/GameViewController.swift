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
        guard isViewLoaded else { return nil }
        return view as? GameView
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupGameView()
    }
    
    // MARK: Setting Methods
    private func setupNavigationItems() {
        navigationItem.title = "RPS Game"
    }
    
    private func setupGameView() {
        gameView?.delegate = self
    }
    
    // MARK: Features
    private func randomGameViewComputerItem() {
        let items = GameView.Item.allCases
        guard let randomItem = items.randomElement() else {
            return
        }
        gameView?.updateComputerChoose(with: randomItem)
    }
}

// MARK: - GameViewController + GameViewDelegate
extension GameViewController: GameViewDelegate {
    
    func gameView(_ gameView: GameView, didChooseItem: GameView.Item) {
        gameView.playerChooseItemLabel.text = didChooseItem.emoji
        randomGameViewComputerItem()
    }
}
