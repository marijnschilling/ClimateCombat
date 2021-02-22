import Foundation
import Combine

struct WeatherInfo: Decodable {
    let grade: Int
    let imageName: String?
    
    init(grade: Int = 0, imageName: String? = nil) {
        self.grade = grade
        self.imageName = imageName
    }
}

class ClimateCombatViewModel: ObservableObject {
    @Published var amsterdam = WeatherInfo()
    @Published var malmo = WeatherInfo()
    
    @Published var score = ""
    
    private let weatherInfoProvider = WeatherInfoProvider()

    var cancellableAmsterdam: AnyCancellable?
    var cancellableMalmo: AnyCancellable?

    var cancellableScore: AnyCancellable?
    
    func getWeatherInfo() {
        
        cancellableAmsterdam = self.weatherInfoProvider.getAmsterdamWeatherInfo().sink(receiveValue: { [weak self] amsterdam in
            self?.cancellableMalmo = self?.weatherInfoProvider.getMalmoWeatherInfo().sink(receiveValue: { [weak self] malmo in
                DispatchQueue.main.async {
                    self?.addGradeToUserDefaults(amsterdam: amsterdam.grade, malmo: malmo.grade)
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
    
    private func addGradeToUserDefaults(amsterdam: Int, malmo: Int) {
        let scores = UserDefaults.standard.scores ?? Scores()
        
        if amsterdam > malmo {
            scores.incrementScore(for: .amsterdam)
        } else if malmo > amsterdam {
            scores.incrementScore(for: .malmo)
        }

        UserDefaults.standard.scores = scores
    }
}
