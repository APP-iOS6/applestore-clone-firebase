//
//  ContentView.swift
//  ApplePark
//
//  Created by 박준영 on 10/7/24.
//

import SwiftUI

struct LoginView: View {
    @State private var id: String = ""
    @State private var pw: String = ""
    @State private var isPresented: Bool = false
    @State private var authState: AuthenticationState = .unauthenticated
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        NavigationStack {
            if isPresented {
                ProductAddView()
            }else {
                  VStack {
                    TextField("ID: ", text: $id)
                        .padding()
                        .background(Color.indigo, in: RoundedRectangle(cornerRadius: 10).stroke() )
                    
                    TextField("PW: ", text: $pw)
                        .padding()
                        .background(Color.indigo, in: RoundedRectangle(cornerRadius: 10).stroke() )
                    Button {
                        Task {
                            isPresented  = await authManager.signInWithGoogle()
                        }
                    } label: {
                        Text("Login Button")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundStyle(.white)
                            .background(.indigo.gradient, in: RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            switch authState {
            default: authState = authState
                
            }
        }
        .onChange(of: authState ){ _, newValue in
            if newValue == .authenticated {
                authState = newValue
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}
