import Foundation
import Combine
import SwiftUI

enum WeatherImage: String {
    case snow_cloudy
    case cloudy
    case cloudy_sunny_cold
    case raining
    case fresh_breeze
    case super_cold
    case super_hot
    case cloudy_sunny_warm
    case sunny_cold
    case unknown
    
    var systemName: String {
        switch self {
        case .snow_cloudy:
            return "cloud.snow"
        case .cloudy:
            return "cloud"
        case .cloudy_sunny_cold:
            return "cloud.sun"
        case .raining:
            return "cloud.rain"
        case .fresh_breeze:
            return "wind"
        case .super_cold:
            return "thermometer.snowflake"
        case .super_hot:
            return "thermometer.sun"
        case .cloudy_sunny_warm:
            return "sun.max"
        case .sunny_cold:
            return "sun.min"
        case .unknown:
            return "questionmark.circle"
        }
    }
}

struct WeatherInfo {
    let grade: Int
    let image: WeatherImage
    
    init(grade: Int = 0, imageName: String = "") {
        self.grade = grade
        self.image = WeatherImage(rawValue: imageName) ?? .unknown
    }
}

enum DayWinner: String {
    case amsterdam
    case malmo
    case draw
}

class ClimateCombatViewModel: ObservableObject {
    @Published var amsterdam = WeatherInfo()
    @Published var malmo = WeatherInfo()
    
    @Published var score = ""
    @Published var dayWinner = DayWinner.draw
    
    private let weatherInfoProvider = WeatherInfoProvider()

    var cancellableAmsterdam: AnyCancellable?
    var cancellableMalmo: AnyCancellable?

    var cancellableScore: AnyCancellable?
    
    func getWeatherInfo() {
        
        cancellableAmsterdam = self.weatherInfoProvider.getAmsterdamWeatherInfo().sink(receiveValue: { [weak self] amsterdam in
            self?.cancellableMalmo = self?.weatherInfoProvider.getMalmoWeatherInfo().sink(receiveValue: { [weak self] malmo in
                DispatchQueue.main.async {
                    if amsterdam.grade > malmo.grade {
                        self?.incrementScoreInUserDefaults(for: .amsterdam)
                        self?.dayWinner = .amsterdam
                    } else if malmo.grade > amsterdam.grade {
                        self?.incrementScoreInUserDefaults(for: .malmo)
                        self?.dayWinner = .malmo
                    } else {
                        self?.dayWinner = .draw
                    }
                    
                    self?.malmo = malmo
                    self?.amsterdam = amsterdam
                }
            })
        })
        
        cancellableScore = UserDefaults.standard
            .publisher(for: \.scores)
            .sink() { [weak self] scores in
                self?.score = scores?.scoreString ?? ""
            }
    }
    
    private func incrementScoreInUserDefaults(for city: City) {
        let scores = UserDefaults.standard.scores ?? Scores()
        scores.incrementScore(for: city)
        UserDefaults.standard.scores = scores
    }
}
