//
//  MissionView.swift
//  MoonShot2
//
//  Created by Saurabh Jamadagni on 09/08/22.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                        
                        Text("Launched \(mission.dateStringForMissionView)")
                            .foregroundColor(.secondary)
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        ZStack {
                                            Image(crewMember.astronaut.id)
                                                .resizable()
                                                .frame(width: 260, height: 180)
                                                .shadow(radius: 10)
                                            
                                            LinearGradient(stops: [
                                                .init(color: .clear, location: 0.3),
                                                .init(color: .black, location: 0.98)
                                            ], startPoint: .top, endPoint: .bottom)
                                                
                                            
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Spacer()
                                                    Text(crewMember.astronaut.name)
                                                        .foregroundColor(.white)
                                                        .font(.headline)
                                                    Text(crewMember.role)
                                                        .foregroundColor(.secondary)
                                                }
                                                .padding([.bottom, .horizontal])
                                                
                                                Spacer()
                                            }
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Not in wiki")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
