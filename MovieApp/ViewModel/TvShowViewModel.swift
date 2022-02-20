import Foundation


protocol TvShowViewModelProtocol: class {
    func didGetShowData(type: UIType)
    func startIndicator()
    func stopIndicator()
}

class TvShowViewModel {
    weak var delegate: TvShowViewModelProtocol?
    var shows: [MovieResult] = []
    private var manager: NetworkManager = NetworkManager()
    var searchID: String = String()

    func numberOfRow() -> Int {
        return shows.count
    }
    
    func cellForRow(at index: Int) -> MovieResult {
        return shows[index]
    }
    
    func getShows(type: ListType){
        manager.getMedia(type: type, searchID: searchID) { [weak self] (response: NetworkResponse<Movie, NetworkError>) in
            guard let self = self else { return }
            print("searchID:", self.searchID)
            self.delegate?.startIndicator()
            switch response {
            case .success(let result):
                print("result:", result)
                self.shows = result.search
                self.delegate?.didGetShowData(type: self.shows.count > 0 ? .data : .none)
                self.delegate?.stopIndicator()
                break
            case .failure(let error):
                print("error:", error.errorMessage)
                self.shows = []
                self.delegate?.didGetShowData(type: .notFound)
                self.delegate?.stopIndicator()
            }
        }
    }
}
