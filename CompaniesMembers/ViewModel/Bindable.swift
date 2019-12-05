//
//  Bindable.swift
//  News Client
//
//  Created by Duy Cao on 12/01/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//


import Foundation

class Bindable<T> {
    typealias ListenerCallback = (T) -> Void
    typealias ValueType = T
    
    private var listener: ListenerCallback?
    
    private var _value: ValueType
    var value: ValueType {
        set {
            _value = newValue
            listener?(newValue)
        }
        get {
            return _value
        }
    }
    
    init(_ value: ValueType) {
        self._value = value
        self.value = value
    }
    
    func bind(listener: @escaping ListenerCallback) {
        self.listener = listener
    }
    
    func bindAndFireEvent(listener: @escaping ListenerCallback) {
        bind(listener: listener)
        listener(value)
    }
    
    func setValueWithoutFire(_ value: ValueType) {
        _value = value
    }
}
