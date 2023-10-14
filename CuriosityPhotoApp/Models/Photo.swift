//
//  Photo.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/18/23.
//

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
