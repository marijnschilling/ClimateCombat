import Foundation
import Combine

struct WeatherInfo: Decodable {
    let grade: String
    let imageName: String?
    
    init(grade: String = "", imageName: String? = nil) {
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
            DispatchQueue.main.async {
                self?.addGradeToUserDefaults(amsterdam.grade, for: .amsterdam)
                self?.amsterdam = amsterdam
            }
        })
        
        cancellableMalmo = weatherInfoProvider.getMalmoWeatherInfo().sink(receiveValue: { [weak self] malmo in
            DispatchQueue.main.async {
                self?.addGradeToUserDefaults(malmo.grade, for: .malmo)
                self?.malmo = malmo
            }
        })
        
        cancellableScore = UserDefaults.standard
            .publisher(for: \.scores)
            .sink() { [weak self] scores in
                self?.score = scores?.scoreString ?? ""
            }
    }
    
    private func addGradeToUserDefaults(_ grade: String, for city: City) {
        let scores = UserDefaults.standard.scores ?? Scores()
        scores.add(grade: grade, for: city)
        UserDefaults.standard.scores = scores
    }
}
