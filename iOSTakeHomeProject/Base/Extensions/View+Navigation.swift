//
//  View+Navigation.swift
//  iOSTakeHomeProject
//
//  Created by Marcin Jędrzejak on 14/09/2022.
//

import SwiftUI

extension View {
    @ViewBuilder
    func embededInNavigation() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
    }
}
