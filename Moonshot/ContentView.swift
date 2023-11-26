//
//  ContentView.swift
//  Moonshot
//
//  Created by Maks Winters on 24.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    let grid = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts")
    let missions: [Mission] = Bundle.main.decode(file: "missions")
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: grid) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 110, height: 110)
                                    .padding()
                                VStack {
                                    Text("Apollo \(mission.id)")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 25))
                            .overlay (
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
