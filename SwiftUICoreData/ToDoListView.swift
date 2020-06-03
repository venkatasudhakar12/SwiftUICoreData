//
//  ToDoListView.swift
//  SwiftUICoreData
//
//  Created by venkata sudhakar on 02/06/20.
//  Copyright © 2020 venkata sudhakar. All rights reserved.
//

import SwiftUI

struct ToDoListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: ToDo.getAllDoToItems()) var toDos:FetchedResults<ToDo>
    @State private var toDoItem:String = ""
    
    var body: some View {
        List{
            Section(header: Text("What's Next")) {
                HStack {
                    TextField("Add new Item",text: $toDoItem)
                    Button(action: {
                        if !self.toDoItem.isEmpty{
                            self.addNewItem()
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .imageScale(.large)
                    }
                }
            }.font(.headline)
            Section(header: Text("ToDo's")) {
                ForEach(self.toDos,id:\.self){ doto in
                    VStack(alignment:.leading){
                        Text(doto.title ?? "")
                            .font(.headline)
                        Text("\(doto.created!)")
                            .font(.caption)
                    }
                }
                .onDelete { (indexSet) in
                    self.deleteItem(index: indexSet)
                }
            }
        }
            .navigationBarTitle("My ToDo's List",displayMode: .large)
            .navigationBarItems(trailing: EditButton())
    }
    func addNewItem(){
        let toDo = ToDo(context: moc)
        toDo.id = UUID()
        toDo.title = toDoItem
        toDo.created = Date()
        do {
            try self.moc.save()
        }catch{
            print(error.localizedDescription)
        }
        self.toDoItem = ""
    }
    func deleteItem(index:IndexSet){
        let todo = self.toDos[index.first!]
        self.moc.delete(todo)
        try? moc.save()
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
