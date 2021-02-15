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
    
    private let weatherInfoProvider = WeatherInfoProvider()
    
    var cancellableMalmo: AnyCancellable?
    var cancellableAmsterdam: AnyCancellable?
    
    func getWeatherInfo() {
        cancellableMalmo = weatherInfoProvider.getMalmoWeatherInfo().sink(receiveValue: { malmo in
            DispatchQueue.main.async {
                self.malmo = malmo
            }
        })
        
        cancellableAmsterdam = weatherInfoProvider.getAmsterdamWeatherInfo().sink(receiveValue: { amsterdam in
            DispatchQueue.main.async {
                self.amsterdam = amsterdam
            }
        })
    }
}
