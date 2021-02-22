//
//  ContentView.swift
//  ClimateCombat
//
//  Created by Marijn Schilling on 04/02/2021.
//

import SwiftUI
import Combine

struct ClimateCombatView: View {
    @ObservedObject var viewModel = ClimateCombatViewModel()
    
    var body: some View {
        VStack {
            VStack() {
                Text("Total")
                    .bold()
                HStack(spacing: 50) {
                    Text("MMÖ")
                    Text(viewModel.score)
                    Text("AMS")
                }
            }
            Spacer()
            
            Text("Amsterdam: \(viewModel.amsterdam.grade)")
            Text("Malmo: \(viewModel.malmo.grade)")
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .onAppear(perform: {
            viewModel.getWeatherInfo()
        })
    }
}

struct ClimateCombatPreviews: PreviewProvider {
    static var previews: some View {
        ClimateCombatView()
    }
}
