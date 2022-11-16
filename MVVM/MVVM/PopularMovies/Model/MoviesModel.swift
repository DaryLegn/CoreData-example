//
//  Model.swift
//  MVVM
//

import Foundation
import CoreData

// MARK: - API Data Model
struct MoviesResult: Decodable {
    let results: [MoviesModel]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct MoviesModel: Decodable {
    let title: String?
    let posterPath: String?
    let overview: String?

    enum CodingKeys: String, CodingKey {
        case title, overview
        case posterPath = "poster_path"
    }
}
