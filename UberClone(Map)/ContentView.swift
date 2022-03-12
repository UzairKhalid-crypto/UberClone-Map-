//
//  ContentView.swift
//  UberClone(Map)
//
//  Created by Devolper.Scorpio on 11/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State var isActive:Bool = false
    var body: some View {
        VStack{
            if self.isActive{
                HomeScreen()
            }else{
                SplashScreen
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
    }
    var SplashScreen : some View{
        Text("Uber")
            .font(.system(size: 34).bold())
            .foregroundColor(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
