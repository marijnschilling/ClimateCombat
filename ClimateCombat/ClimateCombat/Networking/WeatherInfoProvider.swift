import Combine
import Foundation

protocol WeatherInfoProviding {
    func getAmsterdamWeatherInfo() -> AnyPublisher<WeatherInfo, Never>
    func getMalmoWeatherInfo() -> AnyPublisher<WeatherInfo, Never>
}

class WeatherInfoProvider: WeatherInfoProviding {
    func getAmsterdamWeatherInfo() -> AnyPublisher<WeatherInfo, Never> {
        return execute(Endpoint.amsterdam)
            .catch { error in
                //TODO: Handle errors properly
                return Just(WeatherInfo(grade: "?", imageName: nil))
            }.eraseToAnyPublisher()
    }
    
    
    func getMalmoWeatherInfo() -> AnyPublisher<WeatherInfo, Never> {
        return execute(Endpoint.malmo)
            .catch { error in
                //TODO: Handle errors properly
                return Just(WeatherInfo(grade: "?", imageName: nil))
            }.eraseToAnyPublisher()
    }
    
    private func execute<WeatherInfo>(_ requestProvider: RequestProviding) -> AnyPublisher<WeatherInfo, URLError> {
        return URLSession.shared.dataTaskPublisher(for: requestProvider.urlRequest)
            .map { $0.data }
            .map { [weak self] in
                self?.convert(data: $0) as! WeatherInfo
            }
            .eraseToAnyPublisher()
    }
    
    //TODO: Make external scraper class
    private func convert(data: Data) -> WeatherInfo {
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
