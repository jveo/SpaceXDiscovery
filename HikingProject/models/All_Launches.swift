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
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    let uuid = UUID().uuidString
    let flightNumber: Int
    let missionName: String
    let missionID: [String]?
    let launchYear: String
    let launchDateUnix: Int
    let launchDateUTC: String
    let launchDateLocal: String
    let isTentative: Bool
    let tentativeMaxPrecision: String
    let tbd: Bool
    let launchWindow: Int?
    let rocket: Rocket?
    let ships: [String?]?
    let telemetry: Telemetry?
    let launchSite: LaunchSite?
    let launchSuccess: Bool?
    let links: Links?
    let details: String?
    let upcoming: Bool?
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
//    let timeline: [Int?]?
    let crew: [String]?
//    let lastDateUpdate: String?
//    let lastLlLaunchDate, lastLlUpdate: String?
//    let lastWikiLaunchDate, lastWikiRevision, lastWikiUpdate, launchDateSource: String?

    enum CodingKeys: String, CodingKey {
            case flightNumber = "flight_number"
            case missionName = "mission_name"
            case missionID = "mission_id"
            case launchYear = "launch_year"
            case launchDateUnix = "launch_date_unix"
            case launchDateUTC = "launch_date_utc"
            case launchDateLocal = "launch_date_local"
            case isTentative = "is_tentative"
            case tentativeMaxPrecision = "tentative_max_precision"
            case tbd
            case launchWindow = "launch_window"
            case rocket, ships, telemetry
            case launchSite = "launch_site"
            case launchSuccess = "launch_success"
            case links, details, upcoming
            case staticFireDateUTC = "static_fire_date_utc"
            case staticFireDateUnix = "static_fire_date_unix"
            case crew
//            case lastDateUpdate = "last_date_update"
//            case lastLlLaunchDate = "last_ll_launch_date"
//            case lastLlUpdate = "last_ll_update"
//            case lastWikiLaunchDate = "last_wiki_launch_date"
//            case lastWikiRevision = "last_wiki_revision"
//            case lastWikiUpdate = "last_wiki_update"
//            case launchDateSource = "launch_date_source"
                
        }
}

// MARK: - Rocket
struct Rocket: Codable {
    let rocketID, rocketName, rocketType: String?
//    let firstStage: FirstStage?
//    let secondStage: SecondStage?
//    let fairings: JSONNull?

    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
//        case firstStage = "first_stage"
//        case secondStage = "second_stage"
//        case fairings
    }
}

// MARK: - Telemetry
struct Telemetry: Codable {
    let flightClub: String?

    enum CodingKeys: String, CodingKey {
        case flightClub = "flight_club"
    }
}

// MARK: - LaunchSite
struct LaunchSite: Codable {
    let siteID, siteName, siteNameLong: String?

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }
}

// MARK: - Links
struct Links: Codable {
    let missionPatch, missionPatchSmall: String?
    let redditCampaign: String?
    let redditLaunch, redditRecovery, redditMedia, presskit: String?
    let articleLink, wikipedia, videoLink, youtubeID: String?
    let flickrImages: [String]?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case redditCampaign = "reddit_campaign"
        case redditLaunch = "reddit_launch"
        case redditRecovery = "reddit_recovery"
        case redditMedia = "reddit_media"
        case presskit
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case youtubeID = "youtube_id"
        case flickrImages = "flickr_images"
    }
}
