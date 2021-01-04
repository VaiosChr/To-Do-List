//
//  ContentView.swift
//  To-Do List
//
//  Created by Vaios Christodoulou on 31/12/20.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    @State var checked = false
    @State var text = ""
}

struct ContentView: View {
    
    @State private var tasks_array = [Task(checked: false, text: "")]
    
    var body: some View {
        VStack {
            Text("To-Do List").bold()
                .foregroundColor(Color.blue)
                .padding()
            
            HStack {
                Spacer()
                
                Button(action: {tasks_array.append(Task(checked: false, text: ""))}, label: {
                    Image(systemName: "plus")
                        .padding()
                })
            }
             
            ForEach(tasks_array, id: \.id) {task in
                HStack {
                    Button(action: {task.checked = !task.checked}, label: {
                        Image(systemName: task.checked ? "checkmark.square" : "square")
                            .padding(5).padding(.leading)
                    })

                    if task.text == "" {
                        TextField("Task", text: task.$text)
                    }
                    else {
                        Text("\(task.id)")
                    }
                    
                    Spacer()
                }
            }
            
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
