//
//  MovieListTableViewController.swift
//  MovieSearch
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var movies: [Movie] = [] {
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
        self.tableView.rowHeight = 400
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.search(for: "Hot Rod")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movies.isEmpty {
            self.tableView.backgroundView = NoResultsView(frame: UIScreen.main.bounds)
            UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.tableView.backgroundView)
        } else {
            self.tableView.backgroundView = UIView()
            UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: "New search results displayed")
        }
        return self.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell
            else { return UITableViewCell() }
        let movie = self.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.posterImageView.loadPoster(for: movie)
        cell.accessibilityLabel = movie.title
        cell.accessibilityHint = movie.overview
        return cell
    }
    
    // MARK: - Helper functions
    
    private func search(for searchTerm: String) {
        MovieController().fetchMovies(with: searchTerm) { [weak self] movies in
            self?.movies = movies
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
