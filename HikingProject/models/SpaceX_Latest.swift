//
//  spacex_latest.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-14.
//

import Foundation

enum Section {
    case main
}
// MARK: - Launch
struct Launch: Codable, Hashable {
    
    let flightNumber: Int
    let missionName: String
//    let missionID: [String]?
//    let upcoming: Bool
//    let launchYear: String
//    let launchDateUnix: Int
//    let launchDateUTC: String
//    let launchDateLocal: Date
//    let isTentative: Bool
//    let tentativeMaxPrecision: String
//    let tbd: Bool
   

    enum CodingKeys: String, CodingKey {
            case flightNumber = "flight_number"
            case missionName = "mission_name"
//            case missionID = "mission_id"
//            case upcoming
//            case launchYear = "launch_year"
//            case launchDateUnix = "launch_date_unix"
//            case launchDateUTC = "launch_date_utc"
//            case launchDateLocal = "launch_date_local"
//            case isTentative = "is_tentative"
//            case tentativeMaxPrecision = "tentative_max_precision"
//            case tbd
        }
}

