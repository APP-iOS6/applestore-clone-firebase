//
//  ProfileInfo.swift
//  ApplePark
//
//  Created by Soom on 10/10/24.
//

import SwiftUI

struct ProfileInfoAddView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var newNickname: String = ""
    @State private var newRecentlyViewedProducts: [String] = [] 
    
    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $newNickname)
                Button(action: {
                    authManager.profileInfo.nickname = newNickname
                    Task {
                        await authManager.updateUserProfile(email: newNickname, recentlyViewedProducts: newRecentlyViewedProducts)
                    }
                    newNickname = ""
                }, label: {
                    Text("수정하기")
                })
            }
            .navigationTitle("Product Edit")
            
        }
        .onAppear {
            newNickname = authManager.profileInfo.nickname
            }
        }
}

#Preview {
    ProfileInfoView()
}
