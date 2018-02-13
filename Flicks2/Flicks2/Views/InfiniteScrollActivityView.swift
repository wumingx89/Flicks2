//
//  InfiniteScrollActivityView.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import UIKit

class InfiniteScrollActivityView: UIView {

    var activityView = UIActivityIndicatorView()
    static let height = CGFloat(60.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityView.center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
    
    func setup() {
        activityView.activityIndicatorViewStyle = .gray
        activityView.hidesWhenStopped = true
        self.addSubview(activityView)
    }
    
    func stopAnimating() {
        self.activityView.stopAnimating()
        self.isHidden = true
    }
    
    func startAnimating() {
        self.activityView.startAnimating()
        self.isHidden = false
    }
}
