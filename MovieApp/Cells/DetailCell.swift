//
//  DetailCell.swift
//  MovieApp
//
//  Created by MacBook on 20.02.2022.
//

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setView(name: String?, posterPath: String?, description: String?, rating: String?, popularity: String?, runtime: String?) {
        if let name = name {
            movieNameLabel.text = name
        }
        if let description = description {
            movieDescriptionLabel.text = description
        }
        if let posterPath = posterPath {
            ImageLoader().loadImage(with: posterPath, image: movieImageView)
        }
        if let rating = rating {
            movieRatingLabel.text = rating
        }
        if let popularity = popularity {
            moviePopularityLabel.text = popularity
        }
        if let runtime = runtime {
            movieRuntimeLabel.text = runtime
        }
    }
}
