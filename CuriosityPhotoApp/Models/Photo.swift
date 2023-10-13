//
//  Photo.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/18/23.
//


enum JsonURL: String {
    case nasa =
    """
    https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=SzPwsv57rRbHu6c1h0mVfHEuiG4W3hUICvmNgb7R
    """
}

struct PhotoCollection: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
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

struct Camera: Codable {
    let id: Int?
    let cameraName: String
    let roverId: Int?
    let cameraFullName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cameraName = "name"
        case roverId = "rover_id"
        case cameraFullName = "full_name"
    }
}

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

