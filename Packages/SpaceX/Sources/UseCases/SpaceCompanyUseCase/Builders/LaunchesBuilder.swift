//
//  LaunchesBuilder.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Core

struct LaunchesBuilder {
    // MARK: - Properties
    
    private let launches: [LaunchDTO]
    private let rockets: [RocketDTO]
    
    // MARK: - Constructor
    
    init(launches: [LaunchDTO], rockets: [RocketDTO]) {
        self.launches = launches
        self.rockets = rockets
    }
    
    // MARK: - Make
    
    func build() -> [Launch] {
        launches.map {
            .init(
                id: $0.id,
                isSuccess: $0.success ?? false,
                missionName: $0.name,
                date: $0.dateUtc,
                rocket: $0.rocket.flatMap { self.rocket(by: $0) },
                patchImages: patchImages(for: $0.links?.patch),
                sourceLinks: sourceLinks(for: $0.links)
            )
        }
    }
}

// MARK: - Private

private extension LaunchesBuilder {
    private func rocket(by id: String) -> Launch.Rocket? {
        rockets
            .first(where: { $0.id == id })
            .map { Launch.Rocket(id: $0.id, name: $0.name, type: $0.type) }
    }
    
    private func patchImages(for patch: LaunchDTO.Patch?) -> Launch.PatchImages? {
        guard [patch?.large, patch?.small].contains(where: { !($0 ?? "").isEmpty }) else {
            return nil
        }
        return .init(smallPatchImage: patch?.small, largePatchImage: patch?.large)
    }
    
    private func sourceLinks(for links: LaunchDTO.Links?) -> Launch.SourceLinks? {
        guard [links?.article, links?.wikipedia, links?.youtubeId].contains(where: { !($0 ?? "").isEmpty }) else {
            return nil
        }
        return .init(wikipedia: links?.wikipedia, article: links?.article, youtubeId: links?.youtubeId)
    }
}
