//
//  QueryFilter.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

struct QueryFilter: Encodable {
    let query: Query?
    let options: Options?
}

// MARK: - Options

struct Options: Encodable {
    /// If set to false, it will return all docs without adding limit condition. (Default: True)
    ///
    let pagination: Bool?
    
    /// Use offset or page to set skip position
    ///
    let offset: Int?
    
    /// Use offset or page to set skip position
    ///
    let page: Int?
    
    /// Pagination one page limit
    ///
    let limit: Int?
    
    /// Sort order.
    ///
    let sort: SortField?
    
    /// Fields to return (by default returns all fields)
    ///
    let select: [String]?
    
    init?(
        pagination: Bool?,
        offset: Int?,
        page: Int?,
        limit: Int?,
        sort: SortField?,
        select: [String]?
    ) {
        // Prevent send value with nil fields
        let allData: [Any?] = [pagination, offset, page, limit, sort, select]
        guard allData.contains(where: { $0 != nil }) else {
            return nil
        }
        self.pagination = pagination
        self.offset = offset
        self.page = page
        self.limit = limit
        self.sort = sort
        self.select = select
    }
}

// MARK: - Query

struct Query: Encodable {
    let conditions: [Filter]?
    
    init?(conditions: [Filter]?) {
        // Prevent create model with nil fields
        guard !(conditions ?? []).isEmpty else {
            return nil
        }
        self.conditions = conditions
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKey.self)
        try conditions?.forEach {
            try container.encode($0.condition, forKey: .init(key: $0.fieldName))
        }
    }
}
