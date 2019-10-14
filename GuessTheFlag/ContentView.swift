//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mihai Leonte on 10/14/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let size: CGFloat = 60
    @State private var showingAlert = false
    
    var body: some View {
        
        
        ZStack {
            //Color.gray.edgesIgnoringSafeArea(.all)
            //LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            //RadialGradient(gradient: Gradient(colors: [Color.gray, Color.white]), center: .top, startRadius: 20, endRadius: 400).edgesIgnoringSafeArea(.all)
            AngularGradient(gradient: Gradient(colors: [Color.white, Color.black]), center: .topTrailing).edgesIgnoringSafeArea(.all)

            VStack {
                
                
                Button(action: {
                    self.showingAlert = true
                }) {
                    HStack {
                        Image(systemName: "pencil.circle")
                        Text("Edit")
                    }
                }.alert(isPresented: $showingAlert) { 
                    Alert(title: Text("Edit Mode"), message: Text("You have entered edit mode."), dismissButton: .default(Text("OK")))
                }
                
                HStack {
                    Color(red: 1, green: 0.8, blue: 0, opacity: 0.3).frame(width: size, height: size)
                    Color.blue.frame(width: size, height: size)
                    Color.blue.frame(width: size, height: size)
                }
                HStack {
                    Color.blue.frame(width: size, height: size)
                    Color.blue.frame(width: size, height: size)
                    Color.blue.frame(width: size, height: size)
                }
                HStack {
                    Color.blue.frame(width: size, height: size)
                    Color.blue.frame(width: size, height: size)
                    Color.blue.frame(width: size, height: size)
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
