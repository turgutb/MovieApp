//
//  DetailViewController.swift
//  MovieApp
//
//  Created by MacBook on 20.02.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let detailsViewModel: DetailViewModel = DetailViewModel()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       prepareUI()
        getData()

    }
    
    private func prepareUI() {
        navigationItem.largeTitleDisplayMode = .never
        detailsTableView?.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    private func getData() {
        detailsViewModel.delegate = self
        detailsViewModel.getMovieDetails(type: .getID)
    }
}


// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = detailsTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! DetailCell
        if let movieDetail = detailsViewModel.getMovieDetails() {
            cell.setView(name: movieDetail.title, posterPath: movieDetail.poster, description: movieDetail.plot, rating: movieDetail.imdbRating, popularity: movieDetail.year, runtime: movieDetail.runtime)
        }
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailsTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - DetailViewModelProtocol
extension DetailViewController: DetailViewModelProtocol {
    func didGetDetails() {
        DispatchQueue.main.async {
            self.detailsTableView?.reloadData()
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


   













