//
//  ProductAddView.swift
//  ApplePark
//
//  Created by Soom on 10/7/24.
//

import SwiftUI

struct ProductAddView: View {
    let gridItem = Array(repeating: GridItem(.flexible()), count: 2)
    @EnvironmentObject var authManager: AuthStore
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
                        authManager.signOut()
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
