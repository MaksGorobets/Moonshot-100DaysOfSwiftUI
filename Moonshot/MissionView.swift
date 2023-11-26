//
//  MissionView.swift
//  Moonshot
//
//  Created by Maks Winters on 26.11.2023.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        var role: String
        var astronaut: Astronaut
    }
    
    let mission: Mission
    
    let crew: [CrewMember]
    
    let astronauts: [String: Astronaut]
    
    let gradient = LinearGradient(colors: [.red, .blue, .green, .yellow], startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .yellow, radius: 5)
                        .padding(.vertical)
                        .containerRelativeFrame(.horizontal) { width, Axis in
                            width * 0.6
                        }
                    VStack(alignment: .leading) {
                        CustomDevider()
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.description)
                        CustomDevider()
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay (
                                        Capsule()
                                            .strokeBorder(gradient, lineWidth: 2)
                                    )
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20))
                                        .italic()
                                    Text(crewMember.role)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .background(.darkBackground)
            .navigationTitle(mission.displayName)
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
        
        self.crew = mission.crew.map { crewMember in
            if let astronaut = astronauts[crewMember.name] {
                return CrewMember(role: crewMember.role, astronaut: astronaut)
            } else {
                fatalError("Couldn't find \(crewMember.name)")
            }
        }
    }
}

struct CustomDevider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .padding(.vertical)
            .foregroundStyle(.lightBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode(file: "missions")
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
