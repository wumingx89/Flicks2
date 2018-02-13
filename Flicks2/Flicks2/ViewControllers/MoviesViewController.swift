//
//  MoviesViewController.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    fileprivate var loadingMoreView: InfiniteScrollActivityView!
    fileprivate var movies: [Movie] = []
    fileprivate var isMoreDataLoading = false
    fileprivate var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Popular"

        moviesTableView.rowHeight = UITableViewAutomaticDimension
        moviesTableView.estimatedRowHeight = 50
        
        moviesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        // Set up pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        moviesTableView.insertSubview(refreshControl, at: 0)
        
        // Setup infinite scroll view
        let frame = CGRect(x: 0, y: moviesTableView.contentSize.height, width: moviesTableView.bounds.width, height: InfiniteScrollActivityView.height)
        self.loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView.isHidden = true
        moviesTableView.addSubview(loadingMoreView)
        
        var insets = moviesTableView.contentInset
        insets.bottom += InfiniteScrollActivityView.height
        moviesTableView.contentInset = insets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMovies()
    }
    
    @objc func refreshAction(_ refreshControl: UIRefreshControl) {
        getMovies(refreshControl)
    }
    
    fileprivate func getMovies(_ control: UIRefreshControl? = nil, page: Int = 1) {
        MovieDBClient.shared.getMovies(endPoint: .nowPlaying(page: page)) { (moviesList, error) in
            if let moviesList = moviesList {
                self.page = moviesList.page
                if let control = control {
                    self.movies = moviesList.movies
                    control.endRefreshing()
                } else {
                    self.movies.append(contentsOf: moviesList.movies)
                }
                self.moviesTableView.reloadData()
                if page > 1 {
                    self.loadingMoreView.stopAnimating()
                    self.isMoreDataLoading = false
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.prepare(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsVC.movie = movies[indexPath.row]
        show(detailsVC, sender: nil)
    }
}

extension MoviesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading {
            let contentHeight = moviesTableView.contentSize.height
            let offsetThreshold = contentHeight - moviesTableView.bounds.size.height
            
            if scrollView.contentOffset.y > offsetThreshold, moviesTableView.isDragging {
                isMoreDataLoading = true
                
                // Update the loadingMoreView position
                let frame = CGRect(x: 0, y: moviesTableView.contentSize.height, width: moviesTableView.bounds.width, height: InfiniteScrollActivityView.height)
                loadingMoreView.frame = frame
                loadingMoreView.startAnimating()
                
                getMovies(page: self.page + 1)
            }
        }
    }
}
