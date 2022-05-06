//
//  AddNewTaskView.swift
//  UI-557
//
//  Created by nyannyan0328 on 2022/05/06.
//

import SwiftUI


struct AddNewTaskView: View {
    @Environment(\.self) var env
    @EnvironmentObject var model : TaskViewModel
    @Namespace var animation
    
    var body: some View {
        VStack{
            
            Text("Edite Task")
                .font(.largeTitle.weight(.black))
                .lCenter()
                .overlay(alignment: .leading) {
                    
                    Button {
                        env.dismiss()
                           
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3.weight(.black))
                            .foregroundColor(.black)
                    }
                

                    
                }
            
                .overlay(alignment: .trailing) {
                    
                    
                    if let editTask = model.editTask{
                        
                        Button {
                            
                            env.managedObjectContext.delete(editTask)
                           try? env.managedObjectContext.save()
                            env.dismiss()
                        } label: {
                            
                           Image(systemName: "trash")
                            
                        }

                    }
                }
                .opacity(model.editTask == nil ? 0 : 1)
            
            
            
            VStack(alignment: .leading, spacing: 13) {
                
                Text("Task Color")
                    .font(.title3.weight(.light))
                    .foregroundColor(.gray)
                
                
                let color : [String] = ["Yellow","Green","Blue","Purple","Red","Orange"]
                
                
                HStack(spacing:16){
                    
                    
                    ForEach(color,id:\.self){color in
                        
                        Circle()
                            .fill(Color(color))
                            .frame(width: 30, height: 30)
                            .background{
                                
                                if model.taskColor == color{
                                    
                                    Circle()
                                        .stroke(.gray)
                                        .padding(-3)
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                
                                model.taskColor = color
                            }
                        
                    }
                    
                
                }
                
                
                
            }
            .padding(.top,18)
            .lLeading()
            
            Divider()
                .padding(.vertical,30)
            
            VStack(alignment: .leading, spacing: 13) {
                
                Text("Task DeadLine")
                    .font(.title3.weight(.light))
                    .foregroundColor(.gray)
                
                
             
                
                         
                    
                    Text(model.taskDeadline.formatted(date: .abbreviated, time: .omitted) + ", " + model.taskDeadline.formatted(date: .omitted, time: .standard))
                    
                 
                
            }
            .padding(.top,18)
            .lLeading()
            
            .overlay(alignment: .bottomTrailing) {
                
                Button {
                    model.showDatePicker.toggle()
                } label: {
                    
                    
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }

                
            }
        
         
            
            Divider()
                .padding(.vertical,10)
            
            
            VStack(alignment: .leading, spacing: 15) {
                
                
                Text("Task Title")
                    .font(.title3.weight(.light))
                    .foregroundColor(.gray)
                
                TextField("", text: $model.taskTitle)
                    .font(.callout)
                    .padding(.top,15)
                
            }
           Divider()
               
            
            VStack(alignment: .leading, spacing: 15) {
                
                
                Text("Task Type")
                    .font(.title3.weight(.light))
                    .foregroundColor(.gray)
                
             
                let taskTypes: [String] = ["Basic","Urgent","Important"]
                
                HStack(spacing:15){
                  
                    
                    ForEach(taskTypes,id:\.self){type in
                        
                        Text(type)
                            .font(.callout.weight(.semibold))
                            .foregroundColor(model.taskType == type ? .white : .black)
                            .lCenter()
                            .padding(.vertical,10)
                            .background{
                                
                                if model.taskType == type{
                                    
                                    Capsule()
                                        .fill(.black)
                                        .matchedGeometryEffect(id: "TASKTYPE", in: animation)
                                        .shadow(color: .orange, radius: 10, x: 3, y: 3)
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                
                                model.taskType = type
                            }
                            
                            
                        
                    }
                }
                
            }
            .padding(.vertical,10)
            .lLeading()
            
            
            Divider()
            
            
            Button {
                
                if model.addTask(context: env.managedObjectContext){
                    
                    env.dismiss()
                }
                
            } label: {
                
                Text("SAVE TASK")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .lCenter()
                    .padding(.vertical,10)
                    .background{
                        
                        Capsule()
                            .fill(.black)
                    }
            }
            .maxBottom()
            .shadow(color: .orange, radius: 10, x: 3, y: 3)
            .disabled(model.taskTitle == "")
            .opacity(model.taskTitle == "" ? 0.5 : 1)

              
            
        }
     
 
        .padding()
        .maxTop()
        .overlay {
            ZStack{
                
                if model.showDatePicker{
                    
                       
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .onTapGesture {
                                model.showDatePicker.toggle()
                            }
                        
                        DatePicker("", selection: $model.taskDeadline,in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                    
                }
            }
        }
    }
    
}

struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView()
            .environmentObject(TaskViewModel())
    }
}
