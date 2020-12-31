//
//  ContentView.swift
//  To-Do List
//
//  Created by Vaios Christodoulou on 31/12/20.
//

import SwiftUI

struct ContentView: View {
    @State private var checked = false
    var body: some View {
        VStack {
            HStack {
                Text("To-Do List")
                    .foregroundColor(Color.blue)
                    .padding()
            }
            
            HStack {
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Text("New")
                        Image(systemName: "plus")
                            .padding([.top, .bottom, .trailing])
                        
                    }
                })
            }
            HStack {
                Button(action: {
                    checked = !checked
                },
                label: {
                    ZStack {
                        if !checked {
                            Image(systemName: "square").padding()
                        }
                        if checked {
                            Image(systemName: "checkmark.square").padding()
                        }
                    }
                })
                Text("Hello world!")
                Spacer()
            }
            Spacer()
        }
        .coordinateSpace(name: /*@START_MENU_TOKEN@*/CoordinateSpace.local/*@END_MENU_TOKEN@*/)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
