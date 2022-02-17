//
//  SecondContentView.swift
//  Transitions
//
//  Created by Abhijeet Shah on 2/17/22.
//

import SwiftUI

struct SecondContentView: View {
    
    //MARK: PROPERTIES
    @State private var isShow: Bool = false
    @State private var animationType = 1
    
    //MARK: BODY
    var body: some View {
        ZStack {
            if isShow {
                if animationType == 1 {
                    samuraiImageView()
                        .transition(AnyTransition.modifier(active: FlyTransition(pct: 0), identity: FlyTransition(pct: 1)))
                }
            }
                HStack {
                    Button {
                        withAnimation(.easeIn(duration: 1)) {
                            self.animationType = 1
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Fly")
                    }//: BUTTON
                    .frame(width: 30, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)                    
                }//: HSTACK
        }//: ZSTACK
        .ignoresSafeArea(edges: .all)
    }
}

struct SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContentView()
    }
}
