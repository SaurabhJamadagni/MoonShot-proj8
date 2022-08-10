//
//  ContentView.swift
//  MoonShot2
//
//  Created by Saurabh Jamadagni on 09/08/22.
//

import SwiftUI

struct DisplayMissionNameAndLaunch: View {
    let mission: Mission
    
    var body: some View {
        VStack {
            Text(mission.displayName)
                .font(.headline)
                .foregroundColor(.white)
            Text(mission.formattedDateString)
                .font(.caption)
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(.lightBackground)
    }
}

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedDateString)
                                .font(.caption)
                        }
                    }
                    
                }
                .listRowBackground(Color(red: 0.2, green: 0.2, blue: 0.3))
                .listRowSeparatorTint(Color(red: 0.1, green: 0.1, blue: 0.2))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
        .listStyle(.plain)
        .navigationTitle("MoonShot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            DisplayMissionNameAndLaunch(mission: mission)

                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("MoonShot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}

struct ContentView: View {
    @State private var gridIsEnabled = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if gridIsEnabled {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .toolbar {
                Button {
                    gridIsEnabled.toggle()
                } label: {
                    Image(systemName: gridIsEnabled ? "list.bullet" : "square.grid.2x2")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
