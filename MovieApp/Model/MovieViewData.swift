//
//  MovieViewData.swift
//  Movie Application
//
//  Created by MacBook on 12.12.2020.
//

import Foundation

final class MovieViewData {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview!
    }
    var posterURL: URL? {
        if let posterPath = movie.posterPath {
            return createImageURL(path: posterPath)
        }
        
        return nil
    }
    
    private func createImageURL(path: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/original/ + \(path)")!
    }
}
