//
//  TaskViewModel.swift
//  UI-557
//
//  Created by nyannyan0328 on 2022/05/06.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
   @Published var currentTab : String = "Today"
    
    @Published var editTask : Task?
    
    @Published var taskTitle : String = ""
    @Published var taskColor : String = "Yellow"
    @Published var openEditTask : Bool = false
    @Published var taskDeadline : Date = Date()
    @Published var taskType : String = "Basic"
    
    @Published var showDatePicker : Bool = false
    
    
    func resetTask(){
        
        currentTab = "Today"
        taskColor = "Yellow"
        taskType = "Basic"
        editTask = nil
        taskTitle = ""
    }
    func addTask(context : NSManagedObjectContext)->Bool{
        
        
        var task : Task!
        
        if let editTask = editTask {
            
            task = editTask
        }
        else{
            
            task = Task(context: context)
        }
        task.type = taskType
        task.title = taskTitle
        task.deadline = taskDeadline
        task.color = taskColor
        task.isCompleted = false
        
        
        if let _ = try? context.save(){
            
            return true
        }
                       
        return false
                        
    }
    
    func setUpTask(){
        
        
        if let editTask = editTask {
            taskType = editTask.type ?? "Today"
            taskColor = editTask.color ?? "Yellow"
            taskTitle = editTask.title ?? ""
            taskDeadline = editTask.deadline ?? Date()
        }
    }
    
    
}

