//
//  MovieListTableViewController.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var movies: [Movie] = [] {
        willSet {
            DispatchQueue.main.async {
                if newValue.isEmpty {
                    self.tableView.backgroundView = NoResultsView(frame: UIScreen.main.bounds)
                    UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.tableView.backgroundView)
                } else {
                    self.tableView.backgroundView = UIView()
                    UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: "New search results displayed")
                }
            }
        }
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Super class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.search(for: "Hot Rod")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell
            else { return UITableViewCell() }
        let movie = self.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.posterImageView.loadPoster(for: movie)
        cell.isAccessibilityElement = true
        cell.accessibilityLabel = movie.title
        cell.accessibilityHint = movie.overview
        return cell
    }
    
    // MARK: - Helper functions
    
    private func search(for searchTerm: String) {
        MovieService().fetchMovies(with: searchTerm) { [weak self] (result: Result<[Movie], APIServiceError>) in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(let error):
                self?.movies = []
                print(error)
            }
        }
    }
}

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        self.search(for: searchTerm)
    }
}
