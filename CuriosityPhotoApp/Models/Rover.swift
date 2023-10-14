//
//  Rover.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/13/23.
//

struct Rover: Codable {
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
    let totalPhotos: Int
    let cameras: [Camera]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status = "status"
        case totalPhotos = "total_photos"
        case cameras = "cameras"
    }
}
