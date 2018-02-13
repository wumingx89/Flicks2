//
//  MovieCell.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        self.posterImageView.image = nil
        titleLabel.text = nil
        overviewLabel.text = nil
    }
    
    func prepare(with movie: Movie) {
        let url = URL(string: Constants.smallPosterBaseUrl + movie.posterPath)!
        print(url.absoluteString)
        ImageUtils.setImage(for: posterImageView, url: url)
        self.titleLabel.text = movie.title
        self.overviewLabel.text = movie.overview
    }
}
