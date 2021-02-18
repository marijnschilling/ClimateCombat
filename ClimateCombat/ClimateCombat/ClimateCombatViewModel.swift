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
    @Published var malmo = WeatherInfo()
    @Published var amsterdam = WeatherInfo()
    @Published var score = ""
    
    private let weatherInfoProvider = WeatherInfoProvider()
    
    var cancellableMalmo: AnyCancellable?
    var cancellableAmsterdam: AnyCancellable?
    
    func getWeatherInfo() {
        cancellableMalmo = weatherInfoProvider.getMalmoWeatherInfo().sink(receiveValue: { [weak self] malmo in
            self?.add(score: malmo.grade, for: .malmo)
            
        })
        cancellableAmsterdam = self.weatherInfoProvider.getAmsterdamWeatherInfo().sink(receiveValue: { [weak self] amsterdam in
            self?.add(score: amsterdam.grade, for: .amsterdam)
        })
    }
    
    private func add(score: String, for city: City) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let currentDateString = dateFormatter.string(from: Date())
        
        var scores = UserDefaults.standard.scores ?? [String: [String: String]]() // get scores dictionary or create an empty one
        var scoreForDate = scores[currentDateString] ?? [String: String]() // get the score for the date, or create a new dictionary
        
        scoreForDate[city.rawValue] = score // Set (or override) the date score for the city
        scores[currentDateString] = scoreForDate // Set (or override) the scores for the date
        
        UserDefaults.standard.scores = scores // Set (or override) the scores
    }
}
