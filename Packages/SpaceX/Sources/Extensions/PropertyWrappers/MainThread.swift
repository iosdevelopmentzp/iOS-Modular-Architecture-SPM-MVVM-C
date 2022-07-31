//
//  MainThread.swift
//  
//
//  Created by Dmytro Vorko on 28.07.2022.
//

import Foundation

/// Ensures that the closure is called on the main thread
@propertyWrapper
public struct MainThread<Data> {
    private var closure: ArgClosure<Data>?
 
    public var wrappedValue: ArgClosure<Data> {
        get {
            return { data in
                guard !Thread.isMainThread else {
                    self.closure?(data)
                    return
                }
                DispatchQueue.main.async {
                    self.closure?(data)
                }
            }
        }
        
        set {
            self.closure = newValue
        }
    }

    public init(_ closure: ArgClosure<Data>?) {
        self.closure = closure
    }
}
