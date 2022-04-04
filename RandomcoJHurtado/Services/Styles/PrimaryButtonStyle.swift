//
//  PrimaryButtonStyle.swift
//  RandomcoJHurtado
//
//  Created by Jesús Hurtado on 5/4/22.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, minHeight: 18)
            .background(Color.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
    }
}
