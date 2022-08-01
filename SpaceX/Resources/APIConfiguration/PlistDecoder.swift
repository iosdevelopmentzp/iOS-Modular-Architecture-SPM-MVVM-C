//
//  PlistDecoder.swift
//  SpaceX
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Foundation

struct PlistDecoder {
    private struct Constants {
        static let resourcesType = "plist"
    }
    
    func decode<T: PlistDecodableType>() throws -> T {
        let errorFactory = {
            NSError.init(domain: "SpaceX.PlistDecoder", code: 900, userInfo: [
                NSLocalizedDescriptionKey: "Failed attempt decode plist with type: \(T.self)"
            ])
        }
        
        let paths = Bundle.main.paths(
            forResourcesOfType: Constants.resourcesType,
            inDirectory: nil
        ).compactMap(URL.init(fileURLWithPath:))
        
        let expectedFileName = [T.plistFileName, ".", Constants.resourcesType].joined(separator: "")
        
        assert(paths.filter { $0.lastPathComponent == expectedFileName }.count <= 1)
        
        guard let url = paths.first(where: { $0.lastPathComponent == expectedFileName }) else {
            throw errorFactory()
        }
        
        let data = try Data(contentsOf: url)
        
        guard let dict = try PropertyListSerialization.propertyList(
            from: data,
            options: [],
            format: nil
        ) as? [String: Any] else {
            throw errorFactory()
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: dict)
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: jsonData)
    }
}
