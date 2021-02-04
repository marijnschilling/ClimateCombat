import Foundation

protocol RequestProviding {
    var urlRequest: URLRequest { get }
}

enum Endpoint {
    case amsterdam
    case malmo
}

extension Endpoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .amsterdam:
            guard let url = URL(string: "https://www.weeronline.nl/Europa/Nederland/Amsterdam/4058223") else {
preconditionFailure("Invalid URL used to create URL instance")
            }
            return URLRequest(url: url)
        case .malmo:
            guard let url = URL(string: "https://www.weeronline.nl/Europa/Zweden/Malm%C3%B6/4122654") else {
                preconditionFailure("Invalid URL used to create URL instance")
            }
            return URLRequest(url: url)
        }
    }
}
