
import Foundation
import UIKit



struct NetworkManager {
    
    func getMedia<T: Decodable>(type: ListType, searchID: String, completion: @escaping (NetworkResponse<T, NetworkError>) -> Void) {
        let endpoint = setEndPoint(type: type)
        
        let url = APIConstants.BASE_URL + APIConstants.API_KEY + endpoint.rawValue + searchID
        print("url:", url)
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(NetworkResponse.failure(.network))
                }
                if let safeData = data {
                    if let decodedData = try? JSONDecoder().decode(T.self, from: safeData) {
                        completion(NetworkResponse.success(decodedData))
                    } else {
                        completion(NetworkResponse.failure(.decoding))
                    }
                }
            }.resume()
        }
    }
    
    
    func getDetails<T: Decodable>(mediaID: String, type: ListType, completion: @escaping (NetworkResponse<T, NetworkError>) -> Void) {
        let endpoint = setEndPoint(type: type)
        let creditEndpoint = getCreditEndpoint(type: type)
        let url = APIConstants.BASE_URL + APIConstants.API_KEY + endpoint.rawValue + "\(mediaID)"
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(NetworkResponse.failure(.network))
                }
                if let safeData = data {
                    if let decodedData = try? JSONDecoder().decode(T.self, from: safeData) {
                        completion(NetworkResponse.success(decodedData))
                    } else {
                        completion(NetworkResponse.failure(.decoding))
                    }
                }
            } .resume()
        }
    }
    
}

private func setEndPoint (type: ListType) -> EndPoints {
    var endPoint: EndPoints
    
    switch type {
    case .getID:
        endPoint = .getID
    case .getTitle:
        endPoint = .getTitle
    case .getMovie:
        endPoint = .getMovie

    }
    return endPoint
}


private func getCreditEndpoint(type: ListType) -> String {
//    switch type {
//    case .PopularMovies,
//         .TopRateMovies,
//         .NowPlayingMovies,
//         .PopularShows,
//         .TopRatedShows,
//         .MovieDetails,
//         .TvDetails:
//        return "?"
//    case .MovieCast,
//         .TvCast:
        return "/credits?"
        
//    }
}








