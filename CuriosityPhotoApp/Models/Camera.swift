//
//  Camera.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/13/23.
//

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
