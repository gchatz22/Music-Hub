//
//  Connect.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/7/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct ConnectView: View {
    
//    var users: [String] = ["Giannis", "Sofia", "Mpampas", "Mama"]
    @ObservedObject var user: User = User.shared
    @State var itemShowingAlert = false
    @State var selectedItem: User? = nil
    @State var myPartyView: Bool = false
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                HStack{
                    Button(action: {
                        print("Online")
                        self.myPartyView = false
                        SPTAppRemote.checkIfSpotifyAppIsActive({ (val) in
                            if val == true{
                                print("Spotify active")
                            } else {
                                Controller.shared.test()
                            }
                        })
                    }){
                        Text("Online")
                    }.padding()
                    
                    Button(action: {
                        print("Your Party")
                        self.myPartyView = true
                    }){
                        Text("Your Party")
                    }.padding()
                }
                
            
                if self.myPartyView == true {
                    
                    HostingButton()
                    Text("Host View")
                    
                } else {
                
                    List {
                        ForEach(user.friends, id: \.uid){ item in
                            Button(action: {
                                self.itemShowingAlert = true
                                self.selectedItem = item
                            }){
                                Text(item.firstName+" "+item.lastName)
                            }
                        }
                        .alert(isPresented: self.$itemShowingAlert){
                            Alert(title: Text("Important message"), message: Text("Do you want to join the party?"), primaryButton: .default(Text("Join party")) {
    //                            self.hosting.flag = true
                                print("I am supposed to join now")
                            }, secondaryButton: .cancel())
                        }
                    }
                }
            
            }
            .navigationBarTitle("Connect")
            
        }
        
        
        
    }
}

struct HostingButton: View{
    
    @ObservedObject var user: User = User.shared
    @State var hostShowingAlert = false
    
    var body: some View {
        Button(action: {
            self.hostShowingAlert = true
        }){
            Text(self.user.hosting ? "End Party" : "Host Party")
        }
        .padding()
        .alert(isPresented: self.$hostShowingAlert){
            let al: Alert
            
            if self.user.hosting == false {
                al = Alert(title: Text("Important message"), message: Text("Do you want to host a party?"), primaryButton: .default(Text("Host")) {
                    self.user.hosting = true
                }, secondaryButton: .cancel())
            } else {
                al = Alert(title: Text("Important message"), message: Text("Do you want to stop hosting your party?"), primaryButton: .destructive(Text("Stop")) {
                    self.user.hosting = false
                }, secondaryButton: .cancel())
            }
            
            return al
        }
    }
}

struct Connect_Previews: PreviewProvider {
    static var previews: some View {
        ConnectView()
    }
}
