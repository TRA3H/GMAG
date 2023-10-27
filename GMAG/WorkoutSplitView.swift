//
//  WorkoutSplitView.swift
//  GMAG
//
//  Created by Abdon Jesus Baybay on 10/27/23.
//

import SwiftUI

struct WorkoutSplitView: View {
    var body: some View {
        VStack {
            // Week Display
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(DayOfWeek.allCases, id: \.self) { day in
                        Text(day.rawValue)
                            .frame(width: 100, height: 100)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            
            // Workout Split Card Component
            WorkoutSplitCard(splitName: "Chest / Tri", workouts: ["Bench Press", "Tri Pull downs"])
            
            // Add Workout Split Button
            Button(action: {
                // TODO: Add functionality to create a new workout split card
            }) {
                Text("Add Workout Split")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct WorkoutSplitCard: View {
    var splitName: String
    var workouts: [String]
    
    var body: some View {
        VStack {
            Text(splitName)
                .font(.headline)
                .padding(.top)
            
            ForEach(workouts, id: \.self) { workout in
                Text(workout)
            }
            
            Button(action: {
                // TODO: Add functionality to add a new workout to the split
            }) {
                Text("Add Workout")
            }
            .padding(.bottom)
        }
        .frame(width: 200)
        .background(Color.white)
        .shadow(radius: 5)
        .padding()
    }
}

enum DayOfWeek: String, CaseIterable {
    case Mon, Tue, Wed, Thu, Fri, Sat, Sun
}

struct WorkoutSplitView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSplitView()
    }
}
