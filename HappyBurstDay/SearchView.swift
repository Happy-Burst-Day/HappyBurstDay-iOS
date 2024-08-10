//
//  SearchView.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/10/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    @State private var isAddedToWishlist: Bool = false
    @State private var showSnackbar: Bool = false
    
    var body: some View {
        ZStack {
            Color.gray100
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                SearchField()
                    .padding(.bottom, 26)
                    .background(Color.white)
                
                ForEach(viewModel.searchModels.indices, id: \.self) { index in
                    
                    FoodRow(index: index)
                        .padding(.vertical, 3)
                        .environmentObject(viewModel)
                    
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

struct FoodRow: View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    @State private var isAddedToWishlist: Bool = false
    @State private var showSnackbar: Bool = false
    
    var index: Int
    var body: some View {
        
        let searchModel = viewModel.searchModels[index]
        let (icon, message) = viewModel.cautionDetails(for: index)
        let nutritionMessages = viewModel.nutritionMessages(for: index)
        
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 353, height: 112)
                .background(.white)
                .cornerRadius(10)
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 3) {
                        Image(icon)
                        Text(message)
                            .font(.Alert.alert)
                            .foregroundColor(.customOrange)
                    }
                    
                    HStack(spacing: 10) {
                        Text(viewModel.searchModels[index].food)
                            .font(.Title.title3)
                            .foregroundColor(.customBlack)
                        
                        Text("\(viewModel.searchModels[index].calorie) kcal")
                            .font(.Body.body2)
                            .foregroundColor(.gray600)
                            .padding(.top, 4)
                    }
                    
                    HStack(spacing: 7) {
                        Text("essential nutrients")
                            .font(.Alert.alert)
                            . foregroundColor(.customBlack)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 5)
                            .background(Color.lightYellow)
                            .cornerRadius(4)
                        
                        Text("added over 100 people")
                            .font(.Alert.alert)
                            .foregroundColor(.customBlack)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 5)
                            .background(Color.gray200)
                            .cornerRadius(4)
                    }
                }
                
                Spacer()
                
                Image(isAddedToWishlist ? "icon_check" : "icon_plus")
                    .onTapGesture {
                        isAddedToWishlist.toggle()
                        showSnackbar.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSnackbar = false
                        }
                    }
            }
            .frame(width: 313)
        }
    }
}

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
