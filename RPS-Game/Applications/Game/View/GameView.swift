//
//  GameView.swift
//  RPS-Game
//
//  Created by Jeremy Xue on 2020/8/19.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func gameView(_ gameView: GameView, didChooseItem item: GameView.Item)
}

class GameView: UIView {
    
    // MARK: Properties
    weak var delegate: GameViewDelegate?
    
    // MARK: IBOutlets
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var computerPlayerLabel: UILabel!
    @IBOutlet weak var computerChooseItemLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerChooseItemLabel: UILabel!
    
    // MARK: IBActions
    @IBAction private func touchOnScissorsButton(_ sender: UIButton) {
        delegate?.gameView(self, didChooseItem: .scissor)
    }
    
    @IBAction private func touchOnRockButton(_ sender: UIButton) {
        delegate?.gameView(self, didChooseItem: .rock)
    }
    
    @IBAction private func touchOnPaperButton(_ sender: UIButton) {
        delegate?.gameView(self, didChooseItem: .paper)
    }
}

// MARK: - Nested Type
extension GameView {
    
    enum Item: CaseIterable {
        case paper, scissor, rock
    }
}
