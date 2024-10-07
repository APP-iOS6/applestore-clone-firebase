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
    
//    @EnvironmentObject var itemStore: ItemStore
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: gridItem ) {
                        ForEach(0..<10) { item in
                            Text("\(item)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.orange.gradient)
                                )
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .navigationTitle("Product Add View")
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    
                }
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        //                        authManager.signOut()
                        authManager.itemStore?.addItem(Item(name: "name데이터",
                                               category: "name데이터",
                                               price: 100,
                                               description: "name데이터",
                                               stockQuantity: 1200,
                                               imageURL: "name데이터",
                                               color: "name데이터",
                                               isAvailable: true))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ProductAddView()
}

