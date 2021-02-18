//
//  ContentView.swift
//  ClimateCombat
//
//  Created by Marijn Schilling on 04/02/2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = ClimateCombatViewModel()
    
    var cancellable: AnyCancellable?
    
    var body: some View {
        VStack {
            Text("Amsterdam: \(viewModel.amsterdam.grade)")
                .padding()
            Text("Malmo: \(viewModel.malmo.grade)")
                .padding()
            Text(viewModel.score)
        }
        .onAppear(perform: {
            viewModel.getWeatherInfo()
            
            cancellable = UserDefaults.standard
                .publisher(for: \.scores)
                .sink { _ in }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
