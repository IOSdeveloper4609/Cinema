//
//  ParsJson.swift
//  Cinema
//
//  Created by Азат Киракосян on 10.01.2021.
//


import UIKit

struct  NetworkData: Codable {
    let city: [City]
}

struct City: Codable {
    let kkTitleRu: String
    let picture: Picture
    
    enum CodingKeys: String, CodingKey {
        case picture
        case kkTitleRu = "kk_title_ru"
    }
    
}

struct Picture: Codable {
    let url: URL?
}



