//
//  ItemStore.swift
//  ApplePark
//
//  Created by 김수민 on 10/7/24.
//


import Foundation
import Observation
import FirebaseCore
import FirebaseFirestore


class ItemStore: ObservableObject {
    
    private var items: [Item] = []
    
    init() {
        items = [
            Item(name: "iPhone 16 pro", category: "iPhone", price: 155000, description: "티타늄 디자인, 더 널찍해진 15.9cm Super Retina XDR 디스플레이, 각주 1 견고한 최신 세대 Ceramic Shield, 동작 버튼, USB 3 속도의 USB-C 각주 2", stockQuantity: 100, imageURL:
                    "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone16pro-digitalmat-gallery-1-202409?wid=728&hei=666&fmt=p-jpg&qlt=95&.v=1723843057491", color:
                    "데저트 티타늄", isAvailable: true)
        ]
    }
    
    func addItem(_ item: Item){
        items.append(item)
        
        Task {
            do {
                let db = Firestore.firestore()
                try await db.collection("Items").document("\(item.itemId)").setData([
                    "name": item.name,
                    "category": item.category,
                    "color": item.color,
                    "description": item.description,
                    "imageURL": item.imageURL,
                    
                    "price": item.price,
                    "stockQuantity": item.stockQuantity,
                    
                    "isAvailable": item.isAvailable,
                ])
                
                print("Document successfully written!")
            } catch {
                print("Error writing document: \(error)")
            }
        }
    }
    
    func updateItem(_ item: Item) {
        Task {
            do {
                let db = Firestore.firestore()
                try await db.collection("Items").document("\(item.itemId)").updateData([
                    "name": item.name,
                    "category": item.category,
                    "color": item.color,
                    "description": item.description,
                    "imageURL": item.imageURL,
                    
                    "price": item.price,
                    "stockQuantity": item.stockQuantity,
                    
                    "isAvailable": item.isAvailable,
                ])
                
                
                print("Document successfully written!")
            } catch {
                print("Error writing document: \(error)")
            }
        }
        for (index, updateItem) in items.enumerated() {
            if updateItem.itemId == item.itemId {
                items[index].name = item.name
                items[index].category = item.category
                items[index].color = item.color
                items[index].description = item.description
                items[index].imageURL = item.imageURL
                
                items[index].price = item.price
                items[index].stockQuantity = item.stockQuantity
                
                items[index].isAvailable = item.isAvailable
                
            }
        }
    }
    
    private func loadItems() async {
        do{
            let db = Firestore.firestore()
            let snapshots = try await db.collection("Items").getDocuments()
            
            var savedItems: [Item] = []
            
            for document in snapshots.documents {
                let id: String = document.documentID
                
                let docData = document.data()
                let name: String = docData["name"] as? String ?? ""
                let category: String = docData["category"] as? String ?? ""
                let color: String = docData["color"] as? String ?? ""
                let description: String = docData["description"] as? String ?? ""
                let imageURL: String = docData["imageURL"] as? String ?? ""
                
                
                let price: Int = docData["price"] as? Int ?? 0
                let stockQuantity: Int = docData["stockQuantity"] as? Int ?? 0
                
                let isAvailable: Bool = docData["isAvailable"] as? Bool ?? true
                let item: Item = Item(itemId: id,name: name, category: category, price: price, description: description, stockQuantity: stockQuantity, imageURL: imageURL, color: color, isAvailable: isAvailable)
                
                savedItems.append(item)
            }
            
            self.items = savedItems
            
        } catch{
            print("\(error)")
        }
    }
    func fetchIItems() async -> (){
        await loadItems()
    }
    
    //MARK: 카테고리 필터
    func filterByCategory(items: [Item], category: String) -> [Item] {
        return items.filter { $0.category == category }
    }
}


