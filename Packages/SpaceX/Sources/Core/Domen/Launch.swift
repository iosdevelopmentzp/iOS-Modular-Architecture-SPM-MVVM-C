//
//  Launch.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public struct Launch: Equatable {
    // MARK: - Nested
    
    public struct Rocket: Equatable {
        public let id: String
        public let name: String?
        public let type: String?
        
        public init(id: String, name: String?, type: String?) {
            self.id = id
            self.name = name
            self.type = type
        }
    }
    
    public struct PatchImages: Equatable {
        public let smallPatchImage: String?
        public let largePatchImage: String?
        
        public init(smallPatchImage: String?, largePatchImage: String?) {
            self.smallPatchImage = smallPatchImage
            self.largePatchImage = largePatchImage
        }
    }
    
    public struct SourceLinks: Equatable {
        public let wikipedia: String?
        public let article: String?
        public let youtubeId: String?
        
        public init(wikipedia: String?, article: String?, youtubeId: String?) {
            self.wikipedia = wikipedia
            self.article = article
            self.youtubeId = youtubeId
        }
    }
    
    // MARK: - Properties
    
    public let id: String
    public let isSuccess: Bool
    public let missionName: String?
    public let date: Date?
    public let rocket: Rocket?
    public let patchImages: PatchImages?
    public let sourceLinks: SourceLinks?
    
    // MARK: - Constructor
    
    public init(
        id: String,
        isSuccess: Bool,
        missionName: String?,
        date: Date?,
        rocket: Launch.Rocket?,
        patchImages: Launch.PatchImages?,
        sourceLinks: Launch.SourceLinks?
    ) {
        self.id = id
        self.isSuccess = isSuccess
        self.missionName = missionName
        self.date = date
        self.rocket = rocket
        self.patchImages = patchImages
        self.sourceLinks = sourceLinks
    }
}
