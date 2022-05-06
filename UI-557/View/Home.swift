//
//  Home.swift
//  UI-557
//
//  Created by nyannyan0328 on 2022/05/06.
//

import SwiftUI

struct Home: View {
    @StateObject var model : TaskViewModel = .init()
    @Environment(\.self) var env
    @Namespace var animation
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var task : FetchedResults<Task>
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
             
                VStack(alignment: .leading, spacing: 13) {
                    
                    Text("Welcome Back")
                        .font(.callout.weight(.ultraLight))
                    
                    Text("Here`s Updated Today")
                        .font(.title.weight(.black))
                }
               
             
                
                .lLeading()
                
        
                CustomSegnmentBar()
                    .padding(.top,15)
                
                TaskView()
                
            }
            .padding()
          
        }
        .overlay(alignment: .bottom) {
            
            Button {
                model.openEditTask.toggle()
            } label: {
                
                Label {
                    
                    Text("Add to Task")
                    
                } icon: {
                    
                    Image(systemName: "plus.app.fill")
                     
                      
                        
                    
                    
                }
                .foregroundColor(.white)
                .padding()
                .background{
                    
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.black)
                }

            }
         
        }
        .background(
        
            LinearGradient(colors: [
                
                .white.opacity(0.05),
                .white.opacity(0.3),
                .white.opacity(0.2),
                .white.opacity(0.1)
                
                
            ], startPoint: .top, endPoint: .bottom)
        
        )
        .fullScreenCover(isPresented: $model.openEditTask) {
            
            model.resetTask()
            
        } content: {
            
            AddNewTaskView()
                .environmentObject(model)
            
        }

    }
    @ViewBuilder
    func TaskView()->some View{
        
        LazyVStack(spacing:20){
            
          
                
              
            
            
            DynamicFileterdView(currentTab: model.currentTab) { (task : Task) in

                TaskRowView(task: task)
            }
            
        }
    }
    @ViewBuilder
    func TaskRowView(task : Task) -> some View{
        
        VStack(alignment: .leading, spacing: 14) {
            
          
                
           
                
                
                HStack{
                    
                    Text(task.type ?? "")
                        .font(.callout)
                        .padding(.vertical,5)
                        .padding(.horizontal)
                   
                        .background(
                        
                        Capsule()
                            .fill(.white))
                    
                    Spacer()
                    
                    
                    if !task.isCompleted &&  model.currentTab != "Failed"{
                        
                        
                        Button {
                            
                            
                            model.editTask = task
                            model.openEditTask = true
                            model.setUpTask()
                        } label: {
                            
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.black)
                                
                            
                        }

                    }
                    
                }
                
                
                Text(task.title ?? "")
                    .font(.title2.weight(.black))
                    .foregroundColor(.black)
                    .padding(.vertical,10)
                
                HStack(alignment: .bottom, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Label {
                            
                            Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                        } icon: {
                            
                            Image(systemName: "calendar")
                            
                        }
                        .font(.callout)
                        
                        Label {
                            
                            Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                        } icon: {
                            
                            Image(systemName: "clock")
                            
                        }
                        
                        .font(.callout)

                        
                    }
                    .lLeading()
                    
                    if !task.isCompleted && model.currentTab != "Failed"{
                        
                        Button {
                            task.isCompleted.toggle()
                            try? env.managedObjectContext.save()
                        } label: {
                            
                            Circle()
                                .strokeBorder(.black,lineWidth: 1.5)
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        }

                    }
                }
                
            
            
          
            
            
            
         
        }
       .lCenter()
        .padding()
        .background{
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(task.color ?? "Yellow"))
        }
        
        
        
    }
    @ViewBuilder
    func CustomSegnmentBar()->some View{
        
        let tabs = ["Today","Upcoming","Task Done","Failed"]
        
        HStack(spacing:15){
            
            ForEach(tabs,id:\.self){tab in
                
                Text(tab)
                    .font(.callout.weight(.semibold))
                    .foregroundColor(model.currentTab == tab ? .white : .black)
                    .padding(.vertical,7)
                    .lCenter()
                    .background{
                        
                        if model.currentTab == tab{
                            
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation{
                            model.currentTab = tab
                        }
                    }
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
