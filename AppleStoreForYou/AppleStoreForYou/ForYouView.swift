//
//  ForYouView.swift
//  AppleStoreForYou
//
//  Created by Mac on 10/7/24.
//

import SwiftUI

struct ForYouView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("For You")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.leading, .top])
                
                Text("최근 활동")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top, 20)
                
                HStack(spacing: 20) {
                    RecentItemCard(imageName: "applewatch", title: "Apple Watch Series 10")
                    RecentItemCard(imageName: "iphonecase", title: "MagSafe형 Beats iPhone 16 Pro 케이스 – 서밋 스톤")
                }
                .padding(.horizontal)
                
                Text("더 살펴보기")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top, 20)
                
                VStack(spacing: 20) {
                    ExploreCard(icon: "bell", title: "주문 관련 실시간 업데이트를 받아보세요.", description: "알림을 켜고 주문 관련 최신 정보를 받아보세요.")
                    ExploreCard(icon: "applelogo", title: "나에게 맞춘 Apple Store.", description: "더 다양한 기능과 나에게 맞춘 서비스를 경험하려면 '기기'와 '서비스'를 활성화하세요.")
                    ExploreCard(icon: "iphone", title: "쇼핑 목록을 관리하세요.", description: "장바구니에 담긴 항목을 한 번에 관리할 수 있습니다.")
                }
                .padding(.horizontal)
            }
        }.background(Color(red: 243 / 255, green: 242 / 255, blue: 248 / 255))
    }
}

struct RecentItemCard: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "eye.circle")
                    .foregroundColor(.green)
                    .padding(.leading, 10)
                Text("최근 본 정보")
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(.bottom, 5)
            
            Image(systemName: "photo")
                .resizable()
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(16)
            
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .default))
                .padding(10)
        }
        .frame(width: 174, height: 253)
        .background(Color.white)
        .cornerRadius(16)
    }
}

struct ExploreCard: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .padding()
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .default))
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 360, height: 115)
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    ForYouView()
}
