//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by NICK POLYCHRONAKIS on 13/10/19.
//  Copyright © 2019 NICK POLYCHRONAKIS. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAlert = false
    
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria","Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
        
    @State private var score = 0
    
    @State private var totalQuestions = 1
    
    @State private var rotationDegrees = 90.0
    
    @State private var rotationDegreesArray = [0.0, 0.0, 0.0]
    @State private var opacityArray = [1.0, 1.0, 1.0]
    
    @State private var rotationDegreesArrayFor2D = [0.0, 0.0, 0.0]

        
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    HStack {
                        Text("Questions: \(totalQuestions)/10")
                            .foregroundColor(.white)

                        Spacer()
                        Text("Score: \(score)")
                            .foregroundColor(.white)
                    }.padding()
                    Text("Tap the flag of")
                        .fontWeight(.light)
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(width: 300)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth:   1))
                            .shadow(color: .black, radius: 2)
//                            .rotation3DEffect(.degrees(self.rotationDegrees), axis: (x: 0, y: 1, z: 0))
                            .opacity(self.opacityArray[number])
                            .rotation3DEffect(.degrees(self.rotationDegreesArray[number]), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .rotationEffect(Angle(degrees: self.rotationDegreesArrayFor2D[number]), anchor: .leading)
                    }
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
        }
        .onAppear{
            withAnimation {
                self.rotationDegrees = 0.0
            }
        }
        .alert(isPresented: $showAlert) {
            if totalQuestions < 10 {
                return Alert(title: Text(scoreTitle), message: Text("Your score is \(self.score)"), dismissButton: .default(Text("Continue"), action: {
                    self.totalQuestions += 1
                    self.askQuestion()
                }))
            } else {
                return Alert(title: Text("Game Over"), message: Text("Congratulations! Your score is \(self.score)"), dismissButton: .default(Text("Restart Game"), action: {
                    self.restartGame()
                }))
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if totalQuestions == 10 {
            self.showAlert = true
        }
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                self.rotationDegreesArray[number] = 360

                switch number {
                case 0:
                    self.opacityArray[1] = 0.25
                    self.opacityArray[2] = 0.25
                case 1:
                    self.opacityArray[0] = 0.25
                    self.opacityArray[2] = 0.25
                default:
                    self.opacityArray[0] = 0.25
                    self.opacityArray[1] = 0.25
                }
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
            if score > 0 {
                score -= 1
            }
            withAnimation(Animation.interpolatingSpring(stiffness: 20, damping: 1)) {
                self.rotationDegreesArrayFor2D[number] = 90
            }
        }
        showAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.rotationDegreesArray = Array(repeating: 0.0, count: 3)
        withAnimation(.default) {
            self.opacityArray = Array(repeating: 1.0, count: 3)
            self.rotationDegreesArrayFor2D = Array(repeating: 0.0, count: 3)
        }

    }
    
    func restartGame() {
        self.rotationDegrees = 90.0
        score = 0
        totalQuestions = 1
        askQuestion()
        withAnimation {
            self.rotationDegrees = 0.0
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
