//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by venkata sudhakar on 30/05/20.
//  Copyright © 2020 venkata sudhakar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert:Bool = false
    @State private var showUpdateAlert:Bool = false
    @Environment(\.managedObjectContext) var moc
    @State private var selectedemployee:Employee?
    @State private var name:String = ""
    @FetchRequest(entity: Employee.entity(), sortDescriptors: []) var employees:FetchedResults<Employee>
    var body: some View {
        NavigationView {
            List{
                ForEach(employees,id: \.id){ employee in
                    Text(employee.name ?? "")
                        .onTapGesture {
                            withAnimation {
                                self.selectedemployee = employee
                                self.showUpdateAlert.toggle()
                            }
                    }
                }
                .onDelete(perform: deleteEmployee(at:))
                
            }
            .navigationBarTitle("Empoyees",displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    //action add
                    withAnimation {
                        self.showAlert.toggle()
                    }
                    
                }, label: {
                    Image(systemName: "plus.square.fill")
                        .font(.system(size: 30))
                })
                
            )
                .navigationBarItems(leading:
                    EditButton()
                    , trailing:  Button(action: {
                        //action add
                        withAnimation {
                            self.showAlert.toggle()
                        }
                        
                    }, label: {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 30))
                    })
            )
        }
        .alert(isPresented: $showAlert, TextAlert(title: "Add Employee",placeholder: "Enter name", action: {
            if let name = $0 {
                self.addNewEmployee(name: name)
            }
        }))
            .alert(isPresented: $showUpdateAlert, TextAlert(title: "Update Employee",value: selectedemployee?.name ?? "", action: {
                if let name = $0 {
                    self.updateEmployee(emp: self.selectedemployee!, name: name)            }
            }))
        
    }
    func addNewEmployee(name:String){
        let employee = Employee(context: moc)
        employee.id = UUID()
        employee.name = name
        try? moc.save()
    }
    func deleteEmployee(at offsets:IndexSet){
        for index in offsets {
            let emp = employees[index]
            moc.delete(emp)
            try? moc.save()
        }
    }
    func updateEmployee(emp:Employee,name:String){
        emp.name = name
        try? moc.save()
    }
}

