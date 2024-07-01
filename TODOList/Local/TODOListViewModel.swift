//
//  TODOListViewModel.swift
//  TODOList
//
//  Created by Vishal Khokad on 23/06/24.
//

import Foundation
import CoreData


class TODOListViewModel {
    func fetchData(_ completion: ([LocalTODOListModel]) -> Void) {
        var modalArray: [LocalTODOListModel] = []
        let managedContext = PersistentStorage.shared.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TODOItem")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let dateString = data.value(forKey: "date") as! String
                let title = data.value(forKey: "title") as! String
                let description = data.value(forKey: "itemDescription") as! String
                let isCompleted = data.value(forKey: "isCompleted") as! Bool
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                
                guard let date = dateFormatter.date(from: dateString) else {
                    return
                }
                  
                modalArray.append(LocalTODOListModel(date: date, title: title, itemDescription: description, isCompleted: isCompleted))
            }
            completion(modalArray)
        } catch {
            print("Error!")
        }
    }
    
    func updateData(_ newData: LocalTODOListModel) {
        let key = "\(newData.date)"
        let managedContext = PersistentStorage.shared.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TODOItem")
        let predicate = NSPredicate(format: "date = %@", key)
        fetchRequest.predicate = predicate
        do {
            let result = try managedContext.fetch(fetchRequest)
            let data = result.first as! NSManagedObject
            data.setValue(newData.title ,forKey: "title")
            data.setValue(newData.itemDescription, forKey: "itemDescription")
            data.setValue(newData.isCompleted, forKey: "isCompleted")
            data.setValue("\(newData.date)", forKey: "date")
            try managedContext.save()
            print("Updated Successfully...")
        } catch {
            print("Error while updating!")
        }
    }
    
    func deleteData(_ date: String) {
        let managedContext = PersistentStorage.shared.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TODOItem")
        let predicate = NSPredicate(format: "date = %@", date)
        fetchRequest.predicate = predicate
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                managedContext.delete(data)
            }
            try managedContext.save()
            print("Deleted data")
        } catch {
            print("Error while deleting the data")
        }
    }
    
    func addData(_ model: LocalTODOListModel, _ completion: (_ result: Bool) -> Void) {
        let managedContext = PersistentStorage.shared.context
        let todoEntity = NSEntityDescription.entity(forEntityName: "TODOItem", in: managedContext)!
        let todoItem = NSManagedObject(entity: todoEntity, insertInto: managedContext)
        
        todoItem.setValue("\(model.date)", forKey: "date")
        todoItem.setValue(model.title, forKey: "title")
        todoItem.setValue(model.itemDescription, forKey: "itemDescription")
        todoItem.setValue(model.isCompleted as NSNumber, forKey: "isCompleted")
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            print("Error while getting data!")
        }
        
    }
}
