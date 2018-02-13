//
//  Movie.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let voteCount: Int
    let movieId: Int
    let voteAvg: Double
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case movieId = "id"
        case voteAvg = "vote_average"
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
}
