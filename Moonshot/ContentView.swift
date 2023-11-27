//
//  ContentView.swift
//  Moonshot
//
//  Created by Maks Winters on 24.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts")
    let missions: [Mission] = Bundle.main.decode(file: "missions")
    
    @State private var isGrid = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if isGrid {
                    MissionGridView(astronauts: astronauts, missions: missions)
                } else {
                    MissionListView(astronauts: astronauts, missions: missions)
                }
            }
            .toolbar {
                Button("View") {
                    withAnimation {
                        isGrid.toggle()
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct MissionGridView: View {
    
    let grid = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
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
}

struct MissionListView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        LazyVStack() {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                            Text(mission.displayName)
                                .font(.system(size: 25, weight: .light))
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            Spacer()
                        }
                        CustomDevider()
                    }
                }
            }
        }
        .padding()
        .containerRelativeFrame(.horizontal) { width, axis in
            width
        }
    }
}

#Preview {
    ContentView()
}
