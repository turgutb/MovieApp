//
//  MoviesViewController.swift
//  Movie Application
//
//  Created by MacBook on 3.11.2020.
//

import UIKit
import Alamofire
import Kingfisher

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    
    var movies: [Movie] = []
    var apiResult: [APIResult] = []
    var selectedMovies: Int?
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        segmentController(segmentValue: 0)
        
        
    }
    
    
    @IBAction func segmentedControl(sender: UISegmentedControl) {
        let segmentValue = sender.selectedSegmentIndex
        segmentController(segmentValue: segmentValue)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MovieTableViewCell
        let item = movies[indexPath.row]
        let viewModel = MovieTableViewCell.ViewModel(movie: item)
        cell.configure(viewModel: viewModel)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        let item = movies[indexPath.row]
        vc.movie_id = item.id
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func segmentController(segmentValue: Int) {
        
        if segmentValue == 0 {
            
            pop(from: APIConstants.topRatedURL, decodable: APIResult.self) { (APIResult) in
                self.movies = APIResult.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } else if segmentValue == 1 {
            
            pop(from: APIConstants.popularURL, decodable: APIResult.self) { (APIResult) in
                
                self.movies = APIResult.results
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
                
            }
            
        } else if segmentValue == 2 {
            
            pop(from: APIConstants.nowPlayingURL, decodable: APIResult.self) { (APIResult) in
                
                self.movies = APIResult.results
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }
            
        }
        
    }
    
}
 
