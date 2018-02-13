//
//  ImageUtils.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import UIKit
import Alamofire

class ImageUtils {
    static func setImage(for view: UIImageView, defaultImage: UIImage? = nil, url: URL) {
        Alamofire.request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                view.image = UIImage(data: data)
                view.alpha = 0.0
                UIView.animate(withDuration: 0.7) {
                    view.alpha = 1.0
                }
            case .failure(let error):
                print(error.localizedDescription)
                view.image = defaultImage
            }
        }
    }
}
