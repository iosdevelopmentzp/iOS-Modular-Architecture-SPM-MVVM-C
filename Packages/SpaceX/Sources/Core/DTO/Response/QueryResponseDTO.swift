//
//  QueryResponseDTO.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

public struct QueryResponseDTO<Document: Decodable & Equatable>: Decodable, Equatable {
    public let docs: [Document]
    public let totalDocs: Int
    public let limit: Int
    public let offset: Int
    public let prevPage: Int?
    public let hasPrevPage: Bool
    public let nextPage: Int?
    public let hasNextPage: Bool
}
