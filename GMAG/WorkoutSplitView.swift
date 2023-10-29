import SwiftUI

struct WorkoutSplitView: View {
    @State private var currentIndex: Int = 0
    @State private var isAddingSplit: Bool = false
    @GestureState private var dragOffset: CGFloat = 0
    private let cardWidth: CGFloat = 275
    private let cardHeight: CGFloat = 500
    private let spacing: CGFloat = 30
    
    var body: some View {
        GeometryReader { fullView in
            ZStack {
                ForEach(DayOfWeek.allCases.indices, id: \.self) { index in
                    Text(DayOfWeek.allCases[index].rawValue)
                        .frame(width: cardWidth, height: cardHeight)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(25)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.2 : 0.9)
                        .offset(x: CGFloat(index - currentIndex) * (cardWidth + spacing) + dragOffset, y: 0)
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragOffset, body: { (value, state, _) in
                        state = value.translation.width
                    })
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = (currentIndex - 1 + DayOfWeek.allCases.count) % DayOfWeek.allCases.count
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = (currentIndex + 1) % DayOfWeek.allCases.count
                            }
                        }
                    })
            )
            .frame(width: fullView.size.width, height: cardHeight, alignment: .center)
            .position(x: fullView.size.width / 2, y: fullView.size.height / 2)
            .overlay(
                HStack {
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex - 1 + DayOfWeek.allCases.count) % DayOfWeek.allCases.count
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .padding()
                    }
                    Spacer()
                    Button(action: {
                        isAddingSplit.toggle()
                    }) {
                        Text("+ Add New Split")
                            .font(.title2)
                            .padding()
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex + 1) % DayOfWeek.allCases.count
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.title)
                            .padding()
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                , alignment: .bottom
            )
            .sheet(isPresented: $isAddingSplit) {
                AddWorkoutSplitView()
            }
        }
    }
}

struct AddWorkoutSplitView: View {
    @State private var selectedMuscleGroup1: String = "Chest"
    @State private var selectedMuscleGroup2: String = "Back"
    
    let muscleGroups = ["Chest", "Back", "Legs", "Shoulders", "Biceps", "Triceps"]
    
    var availableMuscleGroups1: [String] {
        muscleGroups.filter { $0 != selectedMuscleGroup2 }
    }
    
    var availableMuscleGroups2: [String] {
        muscleGroups.filter { $0 != selectedMuscleGroup1 }
    }
    
    var body: some View {
        VStack {
            HStack {
                Picker("Muscle Group 1", selection: $selectedMuscleGroup1) {
                    ForEach(availableMuscleGroups1, id: \.self) {
                        Text($0)
                    }
                }
                Text("/")
                Picker("Muscle Group 2", selection: $selectedMuscleGroup2) {
                    ForEach(availableMuscleGroups2, id: \.self) {
                        Text($0)
                    }
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)
            
            Button("Add New Workout") {
                // Handle adding a new workout
            }
            .padding()
        }
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
