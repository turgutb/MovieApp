//
//  MovieTableViewCell.swift
//  Movie Application
//
//  Created by MacBook on 9.11.2020.
//

import UIKit
import Kingfisher


class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var movieNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func configure(viewModel: ViewModel) {
        movieNameLabel.text = viewModel.movieNameText
        movieImageView.kf.setImage(with: viewModel.movieImageURL)
    }
    
}


extension MovieTableViewCell {
    
    struct ViewModel {
        
        let movieNameText: String
        var movieImageURL: URL? = nil
        
        init(movie: Movie) {
            movieNameText = movie.title
            if let posterPath = movie.posterPath {
                movieImageURL = URL(string:"https://image.tmdb.org/t/p/original/" + posterPath)
            }
        }
        
        init(tv: TV) {
            movieNameText = tv.original_name
            if let posterPath = tv.posterPath {
                movieImageURL = URL(string:"https://image.tmdb.org/t/p/original/" + posterPath)
                
            }
        }
    }
}

