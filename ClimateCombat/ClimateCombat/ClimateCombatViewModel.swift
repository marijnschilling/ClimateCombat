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
        cancellableMalmo = weatherInfoProvider.getMalmoWeatherInfo().sink(receiveValue: { malmo in
            self.cancellableAmsterdam = self.weatherInfoProvider.getAmsterdamWeatherInfo().sink(receiveValue: { amsterdam in
                DispatchQueue.main.async {
                    self.amsterdam = amsterdam
                    self.malmo = malmo
                    
                    if amsterdam.grade > malmo.grade {
                        UserDefaults.standard.amsterdamScore = UserDefaults.standard.amsterdamScore + 1
                    } else if malmo.grade > amsterdam.grade {
                        UserDefaults.standard.malmoScore = UserDefaults.standard.malmoScore + 1
                    } else {
                        // it's a draw
                    }
                    
                    self.score = "Amsterdam: \(UserDefaults.standard.amsterdamScore) Malmo: \(UserDefaults.standard.malmoScore)"
                }
            })
        })
    }
}
