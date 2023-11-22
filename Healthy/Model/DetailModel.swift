//
//  DetailModel.swift
//  Healthy
//
//  Created by Md Asadullah on 23/11/23.
//

import Foundation

// MARK: - For detail screen

struct DetailApiResponse: Codable {
    let Result: DetailResult
}

struct DetailResult: Codable {
    let Error: String
    let Total: Int
    let Query: Query
    let Language: String
    let Resources: Resources
}

struct Query: Codable {
    let ApiVersion: String
    let ApiType: String
    let TopicId: String
    let ToolId: String?
    let CategoryId: String?
    let PopulationId: String?
    let Keyword: String?
    let Who: String?
    let Age: String?
    let Sex: String?
    let Pregnant: String?
    let TobaccoUse: String?
    let SexuallyActive: String?
    let Category: String?
    let Lang: String
    let ReturnType: String
    let Callback: String?
    let HealthfinderPage: String?
    let APiType: String


    enum CodingKeys: String, CodingKey {
        case ApiVersion = "ApiVersion"
        case ApiType = "ApiType"
        case TopicId = "TopicId"
        case ToolId = "ToolId"
        case CategoryId = "CategoryId"
        case PopulationId = "PopulationId"
        case Keyword = "Keyword"
        case Who = "Who"
        case Age = "Age"
        case Sex = "Sex"
        case Pregnant = "Pregnant"
        case TobaccoUse = "TobaccoUse"
        case SexuallyActive = "SexuallyActive"
        case Category = "Category"
        case Lang = "Lang"
//        case Type = "Type"
        case ReturnType = "ReturnType"
        case Callback = "Callback"
        case HealthfinderPage = "HealthfinderPage"
        case APiType = "APiType"
    }
}

struct Resources: Codable {
    let Resource: [Resource]
}

struct Resource: Codable {
    let Id: String
    let Title: String
    let TranslationId: String
    let TranslationTitle: String
    let Categories: String
    let Populations: String
    let MyHFTitle: String
    let MyHFDescription: String
    let MyHFCategory: String
    let MyHFCategoryHeading: String
    let LastUpdate: String
    let ImageUrl: String
    let ImageAlt: String
    let AccessibleVersion: String
    let RelatedItems: RelatedItems
    let Sections: Sections
    let MoreInfoItems: [String]?
    let HealthfinderLogo: String
    let HealthfinderUrl: String

    enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Title = "Title"
        case TranslationId = "TranslationId"
        case TranslationTitle = "TranslationTitle"
        case Categories = "Categories"
        case Populations = "Populations"
        case MyHFTitle = "MyHFTitle"
        case MyHFDescription = "MyHFDescription"
        case MyHFCategory = "MyHFCategory"
        case MyHFCategoryHeading = "MyHFCategoryHeading"
        case LastUpdate = "LastUpdate"
        case ImageUrl = "ImageUrl"
        case ImageAlt = "ImageAlt"
        case AccessibleVersion = "AccessibleVersion"
        case RelatedItems = "RelatedItems"
        case Sections = "Sections"
        case MoreInfoItems = "MoreInfoItems"
        case HealthfinderLogo = "HealthfinderLogo"
        case HealthfinderUrl = "HealthfinderUrl"
    }
}

struct RelatedItems: Codable {
    let RelatedItem: [RelatedItem]
}

struct RelatedItem: Codable {
    let Id: String
    let Title: String
    let Url: String
}

struct Sections: Codable {
    let section: [Section]
}

struct Section: Codable {
    let Title: String
    let Description: String
    let Content: String
}

struct MoreInfoItem: Codable {
    
}
