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
    @State var imageName = "draw"
    
    var body: some View {
        VStack {
            VStack() {
                Text("Total")
                    .font(.headline)
                    .padding()
                HStack(spacing: 50) {
                    Text("AMS")
                        .font(.title)
                    Text(viewModel.score)
                        .font(.title)
                    Text("MMÖ")
                        .font(.title)
                }
            }
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Image(systemName: viewModel.amsterdam.image.systemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("\(viewModel.amsterdam.grade)")
                        .font(.largeTitle)
                }
                Spacer()
                VStack {
                    Image(systemName: viewModel.malmo.image.systemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    Text("\(viewModel.malmo.grade)")
                        .font(.largeTitle)
                }
                Spacer()
            }
            Spacer()
        }
        .background(
            Image(viewModel.dayWinner.rawValue)
                .resizable()
                .frame(maxHeight: .infinity)
        )
        .frame(maxHeight: .infinity)
        .onAppear(perform: {
            viewModel.getWeatherInfo()
        })
    }
}

struct ClimateCombatPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            ClimateCombatView()
        }
    }
}
