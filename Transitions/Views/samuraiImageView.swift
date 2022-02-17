//
//  TextView.swift
//  Transitions
//
//  Created by Abhijeet Shah on 2/16/22.
//

import SwiftUI

struct samuraiImageView: View {
    var body: some View {
        
            Image("samurai")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                .background(.orange)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        samuraiImageView()
    }
}
