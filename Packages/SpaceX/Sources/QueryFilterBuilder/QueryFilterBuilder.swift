//
//  QueryFilterBuilder.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

public class FilterBuilder {
    // MARK: - Option Properties
    
    private var pagination: Bool?
    private var page: Int?
    private var offset: Int?
    private var limit: Int?
    private var sort: SortField?
    private var select: [String]?
    
    // MARK: - Query Properties
    
    private var conditions: [Filter] = []
    
    // MARK: - Constructor
    
    public init() {}
    
    // MARK: - Build
    
    public func build() -> Encodable {
        let options = Options.init(
            pagination: pagination,
            offset: offset,
            page: page,
            limit: limit,
            sort: sort,
            select: select
        )
        
        let query = Query(conditions: conditions)
            
        return QueryFilter(query: query, options: options)
    }
}

// MARK: - Public Functions

public extension FilterBuilder {
    // MARK: - Adjust Option
    
    func setPaginationOptions(page: Int? = nil, offset: Int? = nil, limit: Int? = nil) -> FilterBuilder {
        self.page = page
        self.offset = offset
        self.limit = limit
        return self
    }
    
    func setPaginationMode(enabled: Bool) -> FilterBuilder {
        self.pagination = enabled
        return self
    }
    
    func setSort(fieldName: String, direction: Direction) -> FilterBuilder {
        self.sort = .init(fieldName: fieldName, direction: direction)
        return self
    }
    
    func setFieldsToReturn(_ fields: [String]) -> FilterBuilder {
        self.select = fields
        return self
    }
    
    // MARK: - Adjust Query
    
    func setRangeFilter(for fieldName: String, range: (lower: String, upper: String)) -> FilterBuilder {
        let condition = RangeCondition(lower: range.lower, upper: range.upper)
        conditions.append(.init(fieldName: fieldName, condition: condition))
        return self
    }
    
    func setInFilter(for fieldName: String, values: [String]) -> FilterBuilder {
        let condition = InCondition(values: values)
        conditions.append(.init(fieldName: fieldName, condition: condition))
        return self
    }
    
    func setEqualFilter<T: Encodable>(for fieldName: String, equalTo value: T) -> FilterBuilder {
        let condition = SimpleTypeCondition(value: value)
        conditions.append(.init(fieldName: fieldName, condition: condition))
        return self
    }
}
