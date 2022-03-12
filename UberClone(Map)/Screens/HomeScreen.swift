    //
    //  HomeScreen.swift
    //  UberClone(Map)
    //
    //  Created by Devolper.Scorpio on 11/03/2022.
    //

import SwiftUI
import MapKit
import CoreLocation

struct HomeScreen : View {
    
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var source : CLLocationCoordinate2D!
    @State var destination : CLLocationCoordinate2D!
    @State var name = ""
    @State var distance = ""
    @State var time = ""
    @State var show = false
    @State var loading = false
    @State var book = false
    @State var doc = ""
    @State var data : Data = .init(count: 0)
    @State var search = false
    
    var body: some View{
        
        ZStack{
            VStack{
                MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$source, destination: self.$destination, name: self.$name,distance: self.$distance,time: self.$time, show: self.$show)
                    .onAppear {
                        self.manager.requestAlwaysAuthorization()
                    }
            }
            VStack{
                HStack(alignment: .top){
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                    
                    
                    Spacer()
                    VStack{
                        Image("Pic")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio( contentMode: .fit)
                            .clipShape(Circle())
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .padding(.top , 10)
                            .onTapGesture {
                                self.search = true
                            }
                    }
                }.padding().padding(.top , 40)
                    .background(
                        LinearGradient(colors: [.white.opacity(0.8),.white.opacity(0)], startPoint: .top, endPoint: .bottom)
                    )
                if self.search{
                    SearchView(show: self.$search, map: self.$map, source: self.$source, destination: self.$destination, name: self.$name, distance: self.$distance, time: self.$time,detail: self.$show)
                }
                Spacer()
                
                if self.destination != nil && self.show{
                    card
                }
            }.background(
                self.search ? Color.black.opacity(0.4).onTapGesture {
                    self.search = false
                } : Color.clear
                    .onTapGesture {
                        
                    }
            )
            if self.loading{
                Indicator()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: self.$alert) { () -> Alert in
            
            Alert(title: Text("Error"), message: Text("Please Enable Location In Settings !!!"), dismissButton: .destructive(Text("Ok")))
        }
    }
    var card : some View{
        
        VStack(alignment: .leading){
            HStack{
                Text("Destination")
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    
                    self.map.removeOverlays(self.map.overlays)
                    self.map.removeAnnotations(self.map.annotations)
                    self.destination = nil
                    
                    self.show.toggle()
                    
                }) {
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }.padding(.leading , 20).padding(.trailing , 20)
            HStack{
                VStack(alignment: .leading){
                    Text(self.name)
                    
                    Text("Distance - "+self.distance+" KM")
                    
                    Text("Expexted Time - "+self.time + "Min")
                }
                Spacer()
                Image("Car")
                    .resizable()
                    .frame(width: 90, height: 80)
                
            }.padding().overlay(RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(Color.black, lineWidth: 3)).padding()
        }
        
        .frame(width: UIScreen.screenWidth, height: 250)
        .background(Color.white
                        .shadow(color: .black, radius: 30)
        )
        .cornerRadius(30.0)
        
        
    }
    
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
