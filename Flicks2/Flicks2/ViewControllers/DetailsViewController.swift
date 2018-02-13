//
//  DetailsViewController.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: Constants.largePosterBaseUrl + movie.posterPath)!
        ImageUtils.setImage(for: posterImageView, url: url)
        navigationItem.title = movie.title
        overviewLabel.text = movie.overview
    }
}
