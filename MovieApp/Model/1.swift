import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

let queryParams: [String: String] = [
    "search": "obi wan kenobi",
    "format": "wookie"
]

var urlComponents = URLComponents()
urlComponents.scheme = "https"
urlComponents.host = "swapi.co"
urlComponents.path = "/api/people"
urlComponents.setQueryItems(with: queryParams)
print(urlComponents.url?.absoluteString)
// https://swapi.co/api/people?search=obi%20wan%20kenobi&format=wookie
