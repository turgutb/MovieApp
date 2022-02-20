//
//  CustomCell.swift
//  MovieApp
//
//  Created by MacBook on 20.02.2022.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var customCellView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView(name: String?, rating: String?, date: String?, posterPath: String?, popularity: String?){
        if let name = name {
            nameLabel.text = name
        }
        ImageLoader().loadImage(with: posterPath, image: posterImageView)
        if let rating = rating {
            ratingLabel.text = rating
        }
        if let date = date {
            releaseDateLabel.text = date
        }
        if let popularity = popularity {
            popularityLabel.text = popularity
        }
    }
}
