//
//  Country.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-13.
//

import Foundation

// MARK: - Welcome
struct Covid: Codable {
    let data: [Data]
    let meta: Meta
}

// MARK: - Datum
struct Data: Codable {
    let type: String
    let area: Area
    let summary, diseaseRiskLevel: String
    let diseaseInfection: DiseaseInfection
    let diseaseCases: DiseaseCases
    let hotspots: String
    let dataSources: DataSources
    let areaRestrictions: [AreaRestriction]
    let areaAccessRestrictions: AreaAccessRestrictions
    let areaPolicy: AreaPolicy
    let subArea: [SubArea]
}

// MARK: - Area
struct Area: Codable {
    let name, areaType, iataCode: String
    let geoCode: GeoCode
}

// MARK: - GeoCode
struct GeoCode: Codable {
    let latitude, longitude: String
}

// MARK: - AreaAccessRestrictions
struct AreaAccessRestrictions: Codable {
    let transportation: Transportation
    let declarartionDocumentations: DeclarartionDocumentations
    let entry: Entry
    let diseaseTesting: DiseaseTesting
    let tracingApplication: Masks
    let quarantineModality: Exit
    let masks: Masks
    let exit: Exit
    let otherRestrictions: OtherRestrictions
}

// MARK: - DeclarartionDocumentations
struct DeclarartionDocumentations: Codable {
    let text, documentRequired: String
    let travelDocumentLink, healthDocumentLink: String
    let date: String
}

// MARK: - DiseaseTesting
struct DiseaseTesting: Codable {
    let when, requirement, text: String
    let rules: String
    let isRequired, date: String
}

// MARK: - Entry
struct Entry: Codable {
    let text: String
    let exemptions: String
    let ban, throughDate: String
    let rules: String
    let date: String
}

// MARK: - Exit
struct Exit: Codable {
    let isAllowed: String?
    let text: String
    let rules: String
    let date: String
    let eligiblePerson: String?
}

// MARK: - Masks
struct Masks: Codable {
    let isRequired, text, date: String
}

// MARK: - OtherRestrictions
struct OtherRestrictions: Codable {
    let text, date: String
}

// MARK: - Transportation
struct Transportation: Codable {
    let text, isBanned, throughDate, date: String
    let transportationType: String
}

// MARK: - AreaPolicy
struct AreaPolicy: Codable {
    let text, status, startDate, endDate: String
    let date: String
}

// MARK: - AreaRestriction
struct AreaRestriction: Codable {
    let text, date, restrictionType: String
}

// MARK: - DataSources
struct DataSources: Codable {
    let governmentSiteLink: String
    let healthDepartmentSiteLink: String
}

// MARK: - DiseaseCases
struct DiseaseCases: Codable {
    let confirmed, deaths, recovered, active: Int
    let date: String
}

// MARK: - DiseaseInfection
struct DiseaseInfection: Codable {
    let rate, level, date: String
    let infectionMapLink: String
}

// MARK: - SubArea
struct SubArea: Codable {
    let area: Area
    let summary, diseaseRiskLevel: String
}

// MARK: - Meta
struct Meta: Codable {
    let language: String
    let links: Links
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
