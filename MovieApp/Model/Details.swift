//
//  Details.swift
//  Movie Application
//
//  Created by MacBook on 4.12.2020.
//

import Foundation

struct Details: Codable {
    
    let id: Int?
    let posterPath: String?
    let overview: String?
 
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case overview
        
    }
    
    
    
}
