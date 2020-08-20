//
//  Box.swift
//  RPS-Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 Jeremy Xue. All rights reserved.
//

import Foundation

class Box<Value> {
    
    typealias ValueChangedAction = (Value) -> Void
    
    // MARK: Properties
    private var valueChangedAction: ValueChangedAction?
    var value: Value {
        didSet {
            valueChangedAction?(value)
        }
    }
    
    // MARK: Initializers
    init(_ value: Value) {
        self.value = value
    }
}

// MARK: - Methods
extension Box:Cancelable {
    
    func bind(_ action: @escaping ValueChangedAction) -> Cancelable {
        valueChangedAction = action
        valueChangedAction?(value)
        return AnyCancelable(self)
    }
    
    func cancel() {
        self.valueChangedAction = nil
    }
}

protocol Cancelable {
    func cancel()
    func store(_ array: inout Array<Cancelable>)
}
extension Cancelable {
    func store(_ array: inout Array<Cancelable>) {
        array.append(self)
    }
}

class AnyCancelable:Cancelable {
    internal init(_ target: Cancelable) {
        self.target = target
    }
    
    var target: Cancelable
    func cancel() {
        target.cancel()
    }
    
    deinit {
        target.cancel()
    }
}
