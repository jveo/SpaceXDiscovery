//
//  Upcoming_Launches.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-16.
//

import Foundation
//https://api.spacexdata.com/v3/launches/upcoming

// MARK: - Upcoming_Launches
struct Upcoming_Launches: Codable, Hashable {
    static func == (lhs: Upcoming_Launches, rhs: Upcoming_Launches) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    let uuid = UUID().uuidString
    let flightNumber: Int?
    let missionName: String?
//    let missionID: [String]?
//    let launchYear: String?
//    let launchDateUnix: Int?
//    let launchDateUTC, launchDateLocal: String?
//    let isTentative: Bool?
//    let tentativeMaxPrecision: String?
//    let tbd: Bool?
//    let launchWindow: String?
//    let rocket: Rocket?
//    let ships: [String]?
//    let telemetry: Telemetry?
//    let launchSite: LaunchSite?
//    let launchSuccess: Bool?
    let links: Links?
//    let details: String?
//    let upcoming: Bool?
//    let staticFireDateUTC: String?
//    let staticFireDateUnix: Int?
//    let timeline: String?

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
//        case missionID = "mission_id"
//        case launchYear = "launch_year"
//        case launchDateUnix = "launch_date_unix"
//        case launchDateUTC = "launch_date_utc"
//        case launchDateLocal = "launch_date_local"
//        case isTentative = "is_tentative"
//        case tentativeMaxPrecision = "tentative_max_precision"
//        case tbd
//        case launchWindow = "launch_window"
//        case rocket, ships, telemetry
//        case launchSite = "launch_site"
//        case launchSuccess = "launch_success"
        case links
//        case details, upcoming
//        case staticFireDateUTC = "static_fire_date_utc"
//        case staticFireDateUnix = "static_fire_date_unix"
//        case timeline
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).


//enum SiteID: String, Codable, Hashable {
//    case ccafsSlc40 = "ccafs_slc_40"
//    case kscLc39A = "ksc_lc_39a"
//    case vafbSlc4E = "vafb_slc_4e"
//}
//
//enum SiteName: String, Codable, Hashable {
//    case ccafsSlc40 = "CCAFS SLC 40"
//    case kscLc39A = "KSC LC 39A"
//    case vafbSlc4E = "VAFB SLC 4E"
//}
//
//enum SiteNameLong: String, Codable, Hashable {
//    case capeCanaveralAirForceStationSpaceLaunchComplex40 = "Cape Canaveral Air Force Station Space Launch Complex 40"
//    case kennedySpaceCenterHistoricLaunchComplex39A = "Kennedy Space Center Historic Launch Complex 39A"
//    case vandenbergAirForceBaseSpaceLaunchComplex4E = "Vandenberg Air Force Base Space Launch Complex 4E"
//}
//
////
//// Hashable or Equatable:
//// The compiler will not be able to synthesize the implementation of Hashable or Equatable
//// for types that require the use of JSONAny, nor will the implementation of Hashable be
//// synthesized for types that have collections (such as arrays or dictionaries).
//
//// MARK: - Fairings
//struct Fairings: Codable, Hashable {
//    let reused: Bool?
//    let recoveryAttempt, recovered: Bool?
//    let ship: String?
//
//    enum CodingKeys: String, CodingKey {
//        case reused
//        case recoveryAttempt = "recovery_attempt"
//        case recovered, ship
//    }
//}
//
////
//// Hashable or Equatable:
//// The compiler will not be able to synthesize the implementation of Hashable or Equatable
//// for types that require the use of JSONAny, nor will the implementation of Hashable be
//// synthesized for types that have collections (such as arrays or dictionaries).
//
//// MARK: - FirstStage
//struct FirstStage: Codable, Hashable {
//    let cores: [Core]?
//}
//
////
//// Hashable or Equatable:
//// The compiler will not be able to synthesize the implementation of Hashable or Equatable
//// for types that require the use of JSONAny, nor will the implementation of Hashable be
//// synthesized for types that have collections (such as arrays or dictionaries).
//
//// MARK: - Core
//struct Core: Codable, Hashable {
//    let coreSerial: String?
//    let flight, block: Int?
//    let gridfins, legs, reused: Bool?
//    let landSuccess: String?
//    let landingIntent: Bool?
//    let landingType, landingVehicle: String?
//
//    enum CodingKeys: String, CodingKey {
//        case coreSerial = "core_serial"
//        case flight, block, gridfins, legs, reused
//        case landSuccess = "land_success"
//        case landingIntent = "landing_intent"
//        case landingType = "landing_type"
//        case landingVehicle = "landing_vehicle"
//    }
//}
//
//enum RocketID: String, Codable, Hashable {
//    case falcon9 = "falcon9"
//    case falconheavy = "falconheavy"
//}
//
//enum RocketName: String, Codable, Hashable {
//    case falcon9 = "Falcon 9"
//    case falconHeavy = "Falcon Heavy"
//}
//
//enum RocketType: String, Codable, Hashable {
//    case ft = "FT"
//}
