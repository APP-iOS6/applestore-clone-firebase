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
    @State private var isShowEditSheet: Bool = false
    @State private var itemDetail: Item? // 삭제할 아이템
    @State private var isShowDeleteAlert: Bool = false  // 알림창 상태 관리
    
    
    @State private var selectedItem: Item = Item(name: "name데이터",
                                                 category: "name데이터",
                                                 price: 100,
                                                 description: "name데이터",
                                                 stockQuantity: 1200,
                                                 imageURL: "name데이터",
                                                 color: "25,20,10/색깔이름",
                                                 isAvailable: true)
    
    var body: some View {
        NavigationStack {
            if isLogout {
                LoginView()
            } else {
                VStack {
                    ScrollView {
                        LazyVGrid(columns: gridItem) {
                            ForEach(itemStore.items, id: \.itemId) { item in
                                Button(action: {
                                    selectedItem = item
                                    isShowEditSheet.toggle()
                                    Task {
                                        await itemStore.loadProducts()
                                    }
                                }, label: {
                                    Text("\(item.name)")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 300)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(itemDetail?.itemId == item.itemId ? Color.orange.opacity(0.5) : Color.orange)
                                        )
                                        .onTapGesture {
                                            itemDetail = item // 선택한 Item을 itemDetail에 저장
                                            print("선택한 아이템Id: \(item.itemId)") // 선택한 아이템 아이디 확인
                                        }
                                })
                            }
                        }
                        .sheet(isPresented: $isShowEditSheet) {
                            ProductEditView(isShowSheet: $isShowEditSheet, itemStore: itemStore, item: $selectedItem)
                        }
                        .onAppear {
                            Task {
                                await itemStore.loadProducts()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .navigationTitle("Product Add View")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                isShowDeleteAlert.toggle()
                            } label: {
                                Image(systemName: "trash")
                            }
                            .disabled(itemDetail == nil) //선택한 아이템이 없으면 버튼 활성화 X
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                Task {
                                    await authManager.itemStore.addProduct(Item(name: "name데이터",
                                                                                category: "name데이터",
                                                                                price: 100,
                                                                                description: "name데이터",
                                                                                stockQuantity: 1200,
                                                                                imageURL: "name데이터",
                                                                                color: "20,34,55/뭔지모르겠는색",
                                                                                
                                                                                isAvailable: true), userID: authManager.userID)
                                    await itemStore.loadProducts()
                                }
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .alert(isPresented: $isShowDeleteAlert) {
                        Alert(title: Text("게시물 삭제"), message: Text("정말로 삭제하시겠습니까?"), primaryButton: .destructive(Text("삭제")) {
                            if let itemToDelete = itemDetail {
                                Task {
                                    await itemStore.deleteProduct(itemToDelete, userID: authManager.userID) // 삭제
                                    await itemStore.loadProducts() // 아이템 목록 로드
                                    print("삭제된 아이템Id: \(itemToDelete.itemId)") // 삭제된 아이템의 ID 확인
                                    itemDetail = nil // 선택한 아이템 초기화
                                }
                            }
                        }, secondaryButton: .cancel(Text("취소")))
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
