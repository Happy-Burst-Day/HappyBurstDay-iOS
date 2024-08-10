//
//  SearchView.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/10/24.
//

import SwiftUI

struct SearchView: View {
    
    @State private var isAddedToWishlist: Bool = false
    @State private var showSnackbar: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                SearchField()
                    .padding(.bottom, 26)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: 353, height: 112)
                        .background(.white)
                        .cornerRadius(10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 3) {
                                Image(.iconCaution)
                                Text("주의가 필요해요")
                                    .font(.Alert.alert)
                                    .foregroundColor(.customOrange)
                            }
                            
                            HStack(spacing: 10) {
                                Text("연어덮밥")
                                    .font(.Title.title3)
                                    .foregroundColor(.customBlack)
                                
                                Text("430 kcal")
                                    .font(.Body.body2)
                                    .foregroundColor(.gray600)
                                    .padding(.top, 4)
                            }
                            
                            HStack(spacing: 7) {
                                Text("필수영양소 충족")
                                    .font(.Alert.alert)
                                    . foregroundColor(.customBlack)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 5)
                                    .background(Color.lightYellow)
                                    .cornerRadius(4)
                                
                                Text("100명 이상 추가")
                                    .font(.Alert.alert)
                                    .foregroundColor(.customBlack)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 5)
                                    .background(Color.gray200)
                                    .cornerRadius(4)
                            }
                        }
                        
                        Spacer()
                            .frame(width: 104)
                        
                        Image(isAddedToWishlist ? "icon_check" : "icon_plus")
                            .onTapGesture {
                                isAddedToWishlist.toggle()
                                showSnackbar.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showSnackbar = false
                                }
                            }
                    }
                }
                
                Spacer()
                
                if showSnackbar {
                    Snackbar()
                        .padding(.bottom, 44)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}



struct SearchField: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack (spacing: 0) {
            Image(.iconBack)
                .padding(.horizontal, 20)
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 17))
                    .padding(.leading, 10)
                    .foregroundColor(.gray600)
                
                TextField("음식을 검색하세요", text: $searchText, onCommit: performSearch)
                    .foregroundColor(.gray600)
                
                if !searchText.isEmpty {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(.vertical, 10)
            .foregroundColor(.gray600)
            .background(Color(.gray100))
            .cornerRadius(12)
            .padding(.trailing, 20)
        }
    }
}

//struct FoodRow: View {
//    @State private var isAddedToWishlist: Bool = false
//    @State private var showSnackbar: Bool = false
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .foregroundColor(.red)
//                .frame(width: 353, height: 112)
//                .background(.white)
//                .cornerRadius(10)
//
//            HStack {
//                VStack(alignment: .leading, spacing: 12) {
//                    HStack(spacing: 3) {
//                        Image(.iconCaution)
//                        Text("주의가 필요해요")
//                            .font(.Alert.alert)
//                            .foregroundColor(.customOrange)
//                    }
//
//                    HStack(spacing: 10) {
//                        Text("연어덮밥")
//                            .font(.Title.title3)
//                            .foregroundColor(.customBlack)
//
//                        Text("430 kcal")
//                            .font(.Body.body2)
//                            .foregroundColor(.gray600)
//                            .padding(.top, 4)
//                    }
//
//                    HStack(spacing: 7) {
//                        Text("필수영양소 충족")
//                            .font(.Alert.alert)
//                            . foregroundColor(.customBlack)
//                            .padding(.vertical, 4)
//                            .padding(.horizontal, 5)
//                            .background(Color.lightYellow)
//                            .cornerRadius(4)
//
//                        Text("100명 이상 추가")
//                            .font(.Alert.alert)
//                            .foregroundColor(.customBlack)
//                            .padding(.vertical, 4)
//                            .padding(.horizontal, 5)
//                            .background(Color.gray200)
//                            .cornerRadius(4)
//                    }
//                }
//
//                Spacer()
//                    .frame(width: 104)
//
//                Image(isAddedToWishlist ? "icon_check" : "icon_plus")
//                    .onTapGesture {
//                        isAddedToWishlist.toggle()
//                        showSnackbar.toggle()
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            showSnackbar = false
//                        }
//                    }
//            }
//        }
//    }
//}

struct Snackbar: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(.iconWishcheck)
            
            Text("위시리스트에 추가되었어요!")
                .font(.Alert.alert)
                .foregroundColor(.white)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .background(Color.customBlack)
        .cornerRadius(10)
    }
}

func performSearch() {
    Task {
        // 검색 api 호출
    }
}

#Preview {
    SearchView()
}
