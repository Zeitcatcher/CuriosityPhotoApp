//
//  Photo.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/18/23.
//

struct Photo {
    let camera: Camera
    let imageURL: String
    let earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case camera = "camera"
        case imageURL = "img_src"
        case earthDate = "earth_date"
        case rover = "rover"
    }
}

struct Camera {
    let id: Int
    let cameraName: String
    let roverId: String
    let cameraFullName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cameraName = "name"
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

struct Rover {
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

