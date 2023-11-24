//
//  History.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-24.
//
import Foundation

// MARK: - WelcomeElement
struct History: Codable, Hashable {
    
    static func == (lhs: History, rhs: History) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    let id: Int?
    let title, eventDateUTC: String?
    let eventDateUnix: Int?
    let flightNumber: Int?
    let details: String?
    let links: Linkage?

    enum CodingKeys: String, CodingKey {
        case id, title
        case eventDateUTC = "event_date_utc"
        case eventDateUnix = "event_date_unix"
        case flightNumber = "flight_number"
        case details, links
    }
}

struct Linkage: Codable, Hashable {
    let reddit: String?
    let article: String?
    let wikipedia: String?
}

typealias Welcome = [History]
