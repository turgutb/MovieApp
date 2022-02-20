//
//  TVViewController.swift
//  MovieApp
//
//  Created by MacBook on 20.02.2022.
//
import UIKit
import Firebase

enum UIType {
    case notFound
    case data
    case none
}

class TvShowViewController: UIViewController, UISearchControllerDelegate  {
    
    @IBOutlet weak var tvShowTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var notFoundView: UIView!
    
    let tvShowViewModel: TvShowViewModel = TvShowViewModel()
    var searching = false
    let search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        getData()
        setSearchBar()
    }

    private func prepareUI() {
        tvShowTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "TvCell")
    }

    private func getData() {
        tvShowViewModel.delegate = self
        didGetShowData(type: .none)
        stopIndicator()
    }
    
    private func setSearchBar() {
        search.delegate = self
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Movie Search"
        navigationItem.searchController = search
        definesPresentationContext = true
    }
}


// MARK: - UITableViewDataSource
extension TvShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvShowTableView.dequeueReusableCell(withIdentifier: "TvCell", for: indexPath) as! CustomCell
        let vm = tvShowViewModel.cellForRow(at: indexPath.row)
        cell.setView(name: vm.title,
                     rating: vm.type == .series ? "Series" : "Movie",
                     date: vm.year,
                     posterPath: vm.poster,
                     popularity: nil)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TvShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(identifier: "MovieDetails") as! DetailViewController
        let vm = tvShowViewModel.cellForRow(at: indexPath.row)
        destinationVC.detailsViewModel.detailID = vm.imdbID
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(vm.imdbID)",
        ])
        navigationController?.pushViewController(destinationVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TvShowViewModelProtocol
extension TvShowViewController: TvShowViewModelProtocol {
    func didGetShowData(type: UIType) {
        DispatchQueue.main.async {
            switch type {
            case .data:
                self.tvShowTableView.isHidden = false
                self.notFoundView.isHidden = true
            case .notFound:
                self.tvShowTableView.isHidden = true
                self.notFoundView.isHidden = false
            case .none:
                self.tvShowTableView.isHidden = true
                self.notFoundView.isHidden = true
            }
            self.tvShowTableView?.reloadData()
        }
    }
    func startIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }
    
    func stopIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}

// MARK: - SearchBar

extension TvShowViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {
            tvShowViewModel.searchID = text
            tvShowViewModel.getShows(type: .getMovie)
        } else {
            didGetShowData(type: .none)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            didGetShowData(type: .none)
            tvShowTableView.reloadData()
            return
        }
        tvShowTableView.reloadData()
    }
   

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let emptyString = ""
        searchBar.text = emptyString
        tvShowViewModel.searchID = emptyString
        didGetShowData(type: .none)
    }
}

