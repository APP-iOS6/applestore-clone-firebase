//
//  ProductAddView.swift
//  ApplePark
//
//  Created by Soom on 10/7/24.
//

import SwiftUI

struct ProductAddView: View {
    let gridItem = Array(repeating: GridItem(.flexible()), count: 2)
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject private var itemStore: ItemStore
    @State private var isLogout: Bool = false
    
    var body: some View {
        NavigationStack {
            if isLogout {
                LoginView()
            } else {
                VStack {
                    ScrollView {
                        LazyVGrid(columns: gridItem) {
                            ForEach(itemStore.items, id: \.itemId) { item in
                                Text("\(item.name)")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 300)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.orange.gradient)
                                    )
                            }
                        }
                        .onAppear {
                            Task {
                                await itemStore.loadItems(userID: authManager.userID)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .navigationTitle("Product Add View")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                Task {
                                    await authManager.itemStore.addItem(Item(name: "name데이터",
                                                                             category: "name데이터",
                                                                             price: 100,
                                                                             description: "name데이터",
                                                                             stockQuantity: 1200,
                                                                             imageURL: "name데이터",
                                                                             color: "name데이터",
                                                                             isAvailable: true), userID: authManager.userID)
                                    await itemStore.loadItems(userID: authManager.userID)
                                }
                            } label: {
                                Image(systemName: "plus")
                            }
                            
                            
                        }
                    }
                }
                
                Button {
                    authManager.signOut()
                    isLogout = true
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                }
            }
        }
    }
}



#Preview {
    NavigationStack {
        ProductAddView()
    }
    .environmentObject(AuthManager())
    .environmentObject(ItemStore())
}

