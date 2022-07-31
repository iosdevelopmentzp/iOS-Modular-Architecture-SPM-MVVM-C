//
//  CoordinatorProtocol.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import UIKit

public protocol CoordinatorProtocol: AnyObject {
    var children: [CoordinatorProtocol] { get }
    
    func start()
    func addChild(_ child: CoordinatorProtocol)
    func childDidFinish(_ child: CoordinatorProtocol)
}
