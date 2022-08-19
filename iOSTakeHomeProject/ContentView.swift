//
//  ContentView.swift
//  iOSTakeHomeProject
//
//  Created by Marcin Jędrzejak on 31/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .onAppear{
                    print("👇 Users Reponse")
                    dump(
                        try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
                    )
                    print("👇 Single User Reponse")
                    dump(
                        try? StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
                    )
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
