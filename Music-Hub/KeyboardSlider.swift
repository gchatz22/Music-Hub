//
//  Keyboard.swift
//  Music-Hub
//
//  Created by Giannis Chatziveroglou on 5/3/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation
import SwiftUI

struct Keyboard: ViewModifier{
    
    @State var offset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content.padding(.bottom, offset).onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                
                let value = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                self.offset = value.height
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
                
                self.offset = 0
            }
        }.animation(.spring())
    }
}

extension View{
    func KeyboardResponsive()->ModifiedContent<Self, Keyboard>{
        return modifier(Keyboard())
    }
}

