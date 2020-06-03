//
//  ToDo+CoreDataProperties.swift
//  SwiftUICoreData
//
//  Created by venkata sudhakar on 02/06/20.
//  Copyright © 2020 venkata sudhakar. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    static func getAllDoToItems() -> NSFetchRequest<ToDo> {
        
        let request:NSFetchRequest<ToDo> = ToDo.fetchRequest() as! NSFetchRequest<ToDo>
        let sort = NSSortDescriptor(key: "created", ascending: true)
        request.sortDescriptors = [sort]
        return request
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var created: Date?

}
