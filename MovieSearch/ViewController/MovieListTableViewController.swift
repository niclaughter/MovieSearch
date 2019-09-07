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
            // TODO: having willSet / didSets that get big like this make
            // code harder to read, especially when you are dispatching to main queue.
            // I would refactor this chunk into a function and just call it from didSet
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
        // TODO: discuss use of self
        // As a general swift practice `self` should only be used when necessary
        // such as in a closure or when unwrapping variables using the same name
        // `if let someOptional = self.someOptional {`
        return self.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: identifiers are better to match class names using PascalCase
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell {

            let movie = self.movies[indexPath.row]

            cell.configure(movie: movie)

            return cell

        }

        preconditionFailure("Can't create Cell for row at indexPath: \(indexPath)")
    }
    
    // MARK: - Helper functions
    
    private func search(for searchTerm: String) {
        // TODO: discuss dependency injection
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
        // TODO: consider what happens if the user clears the search field,
        // do we want to leave the last results visilbe OR clear them?
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        self.search(for: searchTerm)
    }
}
