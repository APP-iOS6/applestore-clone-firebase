//
//  ContentView.swift
//  ApplePark
//
//  Created by 박준영 on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var id: String = ""
    @State private var pw: String = ""
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                TextField("ID: ", text: $id)
                    .padding()
                    .background(Color.indigo, in: RoundedRectangle(cornerRadius: 10).stroke() )
                
                TextField("PW: ", text: $pw)
                    .padding()
                    .background(Color.indigo, in: RoundedRectangle(cornerRadius: 10).stroke() )
                Button {
                    
                } label: {
                    Text("Login Button")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundStyle(.white)
                        .background(.indigo.gradient, in: RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal, 20)
            .navigationDestination(isPresented: $isPresented) {
                ProductAddView()
            }
        }
    }
}

#Preview {
    ContentView()
}
