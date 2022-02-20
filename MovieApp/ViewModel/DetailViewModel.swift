
import Foundation

protocol DetailViewModelProtocol: class {
    func didGetDetails()
    func startIndicator()
    func stopIndicator()
}

class DetailViewModel {
    weak var delegate: DetailViewModelProtocol?
    public var detailID: String = String()
    private var details: MovieDetails? = nil
    private var manager: NetworkManager = NetworkManager()
    
    func getMovieDetails() -> MovieDetails? {
        return details
    }
    
    func getMovieDetails(type: ListType) {
        manager.getDetails(mediaID: detailID, type: type) { [weak self] (response: NetworkResponse<MovieDetails, NetworkError>) in
            guard let self = self else { return }
            print("detailID:", self.detailID)
            self.delegate?.startIndicator()
            switch response {
            case .success(let result):
                self.details = result
                self.delegate?.didGetDetails()
                self.delegate?.stopIndicator()
                break
            case .failure(let error):
                print(error.errorMessage)
                self.delegate?.stopIndicator()
            }
        }
    }
}
