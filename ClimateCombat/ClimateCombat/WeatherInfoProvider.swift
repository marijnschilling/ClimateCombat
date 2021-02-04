import Combine

protocol WeatherInfoProviding {
    var apiSession: APISessionProviding { get }
    
    func getAmsterdamWeatherInfo() -> AnyPublisher<WeatherInfo, Never>
    func getMalmoWeatherInfo() -> AnyPublisher<WeatherInfo, Never>
}

class WeatherInfoProvider: WeatherInfoProviding {
    let apiSession: APISessionProviding
    
    init(apiSession: APISessionProviding) {
        self.apiSession = apiSession
    }
    
    func getAmsterdamWeatherInfo() -> AnyPublisher<WeatherInfo, Never> {
        return apiSession.execute(Endpoint.amsterdam)
            .catch { error in
            return Just(WeatherInfo(grade: "?", imageName: nil))
        }.eraseToAnyPublisher()
    }
    
    
    func getMalmoWeatherInfo() -> AnyPublisher<WeatherInfo, Never> {
      return apiSession.execute(Endpoint.malmo)
        .catch { error in
          return Just(WeatherInfo(grade: "?", imageName: nil))
        }.eraseToAnyPublisher()
    }
}
