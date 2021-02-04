import Combine
import Foundation

protocol APISessionProviding {
    func execute<WeatherInfo>(_ requestProvider: RequestProviding) -> AnyPublisher<WeatherInfo, URLError>
}

struct APISession: APISessionProviding {
    func execute<WeatherInfo>(_ requestProvider: RequestProviding) -> AnyPublisher<WeatherInfo, URLError> {
        return URLSession.shared.dataTaskPublisher(for: requestProvider.urlRequest)
            .map { $0.data }
            .map { convert(data: $0) as! WeatherInfo} // Why do I need to unwrapp?
            .eraseToAnyPublisher()
    }
    
    
    func convert(data: Data) -> WeatherInfo {
        let htmlString = String(decoding: data, as: UTF8.self)
        
        var grade = "?"
        if let range = htmlString.range(of: "<img alt=\"grade_") {
            let substring = htmlString[range.upperBound...]
            grade = String(substring.first ?? "?") //TODO: make it work for 10 :)
        }
        
        var imageName: String?
        if let range = htmlString.range(of: "weatherSymbol\":{\"bgCode\":\"") {
            let string = String(htmlString[range.upperBound...])
            if let imageNameRange = string.range(of: "\"") {
                imageName = String(string[...imageNameRange.lowerBound].dropLast())
            }
        }
        
        return WeatherInfo(grade: grade, imageName: imageName)
    }
}
