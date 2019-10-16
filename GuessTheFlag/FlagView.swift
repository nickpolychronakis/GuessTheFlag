//
//  FlagView.swift
//  GuessTheFlag
//
//  Created by NICK POLYCHRONAKIS on 16/10/19.
//  Copyright © 2019 NICK POLYCHRONAKIS. All rights reserved.
//

import SwiftUI

struct FlagView: View {
    var nameOfImage: String
    var body: some View {
        Image(self.nameOfImage)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth:   1))
            .shadow(color: .black, radius: 2)
    }
}

//struct FlagView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlagView()
//    }
//}
