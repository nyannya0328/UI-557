//
//  ContentView.swift
//  UI-557
//
//  Created by nyannyan0328 on 2022/05/06.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View{
        
        
        NavigationView{
            
            Home()
                .navigationTitle("Task Maneger")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
  
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func getRect()->CGRect{
        
        
        return UIScreen.main.bounds
    }
    
    func lLeading()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    func lTreading()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .trailing)
    }
    func lCenter()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .center)
    }
    
    func maxHW()->some View{
        
        self
            .frame(maxWidth:.infinity,maxHeight: .infinity)
        
    
    }

 func maxTop() -> some View{
        
        
        self
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
            
    }

 func maxBottom()-> some View{
        
        self
            .frame(maxHeight:.infinity,alignment: .bottom)
    }

  func maxTopLeading()->some View{
        
        self
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
        
    }
}
