//
//  UITableViewDiffableDataSource+ItemsGetter.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import UIKit

public extension UITableViewDiffableDataSource {
    func section(by index: Int) -> SectionIdentifierType? {
        let sections = snapshot().sectionIdentifiers
        assert(sections.count > index)
        return sections[safe: index]
    }
    
    func item(by indexPath: IndexPath) -> ItemIdentifierType? {
        guard let section = section(by: indexPath.section) else {
            return nil
        }
        let items = snapshot().itemIdentifiers(inSection: section)
        assert(items.count > indexPath.row)
        return items[safe: indexPath.row]
    }
}
