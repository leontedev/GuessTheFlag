//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mihai Leonte on 10/14/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var userScore = 0
    
    @State private var animationAmount = 0.0
    // Challenge #1
    @State private var isFlipAnimated: [Bool] = [false, false, false]
    // Challenge #2
    @State private var isOpacityAnimated: [Bool] = [false, false, false]
    // Challenge #3
    @State private var isWrongAnswer: Bool = false
    
    var body: some View {
        ZStack {
            //Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(country: self.countries[number])
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                    }.rotation3DEffect(.degrees(self.isFlipAnimated[number] ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(self.isOpacityAnimated[number] ? (self.isWrongAnswer ? 0 : 0.25) : 1)
                }
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) { () -> Alert in
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) { self.askQuestion() })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            scoreMessage = "Well done, you increased your score to \(userScore)"
            withAnimation(.default) {
                isFlipAnimated[number] = true
                for i in 0..<isOpacityAnimated.count {
                    if i != number {
                        isOpacityAnimated[i] = true
                    }
                }
            }
            
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "Oops, that's the flag of \(countries[number])"
            isWrongAnswer = true
            withAnimation(.default) {
                for i in 0..<isOpacityAnimated.count {
                    if i != correctAnswer {
                        isOpacityAnimated[i] = true
                    }
                }
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isFlipAnimated = [false, false, false]
        isOpacityAnimated = [false, false, false]
        isWrongAnswer = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
