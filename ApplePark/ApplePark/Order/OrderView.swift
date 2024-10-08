//
//  OrderView.swift
//  ApplePark
//
//  Created by 김종혁 on 10/8/24.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject private var orderStore: OrderStore
    
    let itemId: String
    let productName: String
    let imageURL: String
    let unitPrice: Int
    
    var body: some View {
        VStack {
            Text("ItemID: \(itemId)")
                .padding()
            Text("제품명: \(productName)")
                .padding()
            Text("단가: \(unitPrice)")
                .padding()
            
            Spacer()
            
            Button {
                Task {
                    let newOrder = Order(
                        trackingNumber: "19082947892",
                        orderDate: Date(),
                        shippingAddress: "우리집",
                        phoneNumber: "010-4444-3333",
                        productName: productName,
                        imageURL: imageURL,
                        color: "빨간색",
                        itemId: itemId,
                        hasAppleCarePlus: false,
                        quantity: 3,
                        unitPrice: unitPrice,
                        bankName: "국민은행",
                        accountNumber: "2194-1234-5678"
                    )
                    
                    await orderStore.addOrder(newOrder, userID: authManager.userID)
                    await orderStore.loadOrder(userID: authManager.userID)
                }
            } label: {
                Text("상품 추가")
                    .font(.title)
            }
        }
    }
}

//#Preview {
//    OrderView(itemId: "sampleItemId", productName: "Sample Product", imageURL: "http://example.com/image.jpg", unitPrice: 1000)
//}


