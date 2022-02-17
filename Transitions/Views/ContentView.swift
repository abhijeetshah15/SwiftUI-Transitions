//
//  Main.swift
//  Transitions
//
//  Created by Abhijeet Shah on 2/16/22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: PROPERTIES
    @State private var isShow: Bool = false
    @State private var animationType = 1
    @State private var showOther: Bool = false
    
    //MARK: BODY
    var body: some View {
        ZStack {
            if isShow {
                if animationType == 1 {
                    samuraiImageView()
                        .transition(AnyTransition.asymmetric(
                            insertion: AnyTransition.modifier(
                                active: ShapeClipModifier(shape: StripesShape(insertion: true, pct: 1, stripes: 75, horizontal: true)),
                                identity: ShapeClipModifier(shape: StripesShape(insertion: true, pct: 0, stripes: 75, horizontal: true))),
                            removal: AnyTransition.modifier(
                                active: ShapeClipModifier(shape: StripesShape(insertion: true, pct: 1, stripes: 75, horizontal: true)),
                                identity: ShapeClipModifier(shape: StripesShape(insertion: true, pct: 0, stripes: 75, horizontal: true)))))
                }
                else if animationType == 2 {
                    samuraiImageView()
                        .transition(AnyTransition.modifier(
                            active: ShapeClipModifier(shape: RectangularShape(pct: 0.5)),
                            identity: ShapeClipModifier(shape: RectangularShape(pct: 0))))
                }
                else if animationType == 3 {
                    samuraiImageView()
                        .transition(AnyTransition.modifier(
                            active: ShapeClipModifier(shape: CircleClipShape(pct: 0.5)),
                            identity: ShapeClipModifier(shape: CircleClipShape(pct: 0))))
                }
                else if animationType == 4 {
                    samuraiImageView()
                        .transition(AnyTransition.modifier(
                            active: ClipShapeModifier(shape: ScaledCircle(animatableData: 0)),
                            identity: ClipShapeModifier(shape: ScaledCircle(animatableData: 1))
                        ))
                    
                }
                else if animationType == 5 {
                    samuraiImageView()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
                else if animationType == 6 {
                    samuraiImageView()
                        .transition(AnyTransition.modifier(
                            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
                            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
                        ))
                }
                else if animationType == 7 {
                    samuraiImageView()
                        .transition(AnyTransition.move(edge: .leading).combined(with: AnyTransition.opacity).combined(with: .scale))
                }
                else if animationType == 8 {
                    samuraiImageView()
                        .transition(AnyTransition.modifier(active: ClipEffect(value: 0), identity: ClipEffect(value: 1)))
                }
                else if animationType == 9 {
                    samuraiImageView()
                        .transition(AnyTransition.modifier(active: SlidingDoorEffect(shift: UIScreen.main.bounds.width), identity: SlidingDoorEffect(shift: 0)))
                }                
            }
            
            ScrollView(.horizontal) {
                HStack {
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeIn(duration: 1)) {
                            self.animationType = 1
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Stripes")
                    }//: BUTTON
                    .frame(width: 60, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                    
                    Button {
                        withAnimation(.easeIn(duration: 1)) {
                            self.animationType = 2
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Rect")
                    }//: BUTTON
                    .frame(width: 60, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                    
                    Button {
                        withAnimation(.easeIn(duration: 1)) {
                            self.animationType = 3
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Circular")
                    }//: BUTTON
                    .frame(width: 60, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                    
                    Button {
                        withAnimation(.easeIn(duration: 1)) {
                            self.animationType = 4
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Scaled Circle")
                    }//: BUTTON
                    .frame(width: 100, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.animationType = 5
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Slide")
                    }//: BUTTON
                    .frame(width: 60, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.animationType = 6
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Pivot")
                    }//: BUTTON
                    .frame(width: 60, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.animationType = 7
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Curve In")
                    }//: BUTTON
                    .frame(width: 65, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.animationType = 8
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Round Rect")
                    }//: BUTTON
                    .frame(width: 90, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.animationType = 9
                            self.isShow.toggle()
                        }
                    } label: {
                        Text("Sliding Door")
                    }//: BUTTON
                    .frame(width: 100, height: 20)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.white), radius: 20, x: 2, y: 2)
                    .padding(.top, 700)
                }//: HSTACK
            }//: SCROLLVIEW
        }//: ZSTACK
        .ignoresSafeArea(edges: .all)
    }
}

//MARK: PREVIEW
struct Main_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
