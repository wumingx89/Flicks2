//
//  MoviesList.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import Foundation


struct MoviesList: Decodable {
    let movies: [Movie]
    let page: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalPages = "total_pages"
    }
}
