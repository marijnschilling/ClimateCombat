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
                    .font(.headline)
                HStack(spacing: 50) {
                    Text("AMS")
                        .font(.body)
                    Text(viewModel.score)
                        .font(.body)
                    Text("MMÖ")
                        .font(.body)
                }
            }
            Spacer()
            Image(systemName: viewModel.amsterdam.image.systemName)
            Image(systemName: viewModel.malmo.image.systemName)
            HStack {
                Spacer()
                Text("\(viewModel.amsterdam.grade)")
                    .font(.largeTitle)
                Spacer()
                Text("\(viewModel.malmo.grade)")
                    .font(.largeTitle)
                Spacer()
            }
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
