//
//  SearchView.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/10/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var naviPath:[NaviPath]
    @StateObject private var viewModel = SearchViewModel()
    
    @State private var isAddedToWishlist: Bool = false
    @State private var showSnackbar: Bool = false
    
    var body: some View {
        ZStack {
            Color.gray100
                .ignoresSafeArea()
            
            VStack {
                SearchField()
                    .padding(.bottom, 22)
                    .background(Color.white)
                
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.searchModels.indices, id: \.self) { index in
                        
                        FoodRow(showSnackbar: $showSnackbar, index: index)
                            .padding(.vertical, 3)
                            .environmentObject(viewModel)
                    }
                }
                
            }
            if showSnackbar {
                Snackbar()
                    .padding(.top, 600)
            }
            
        }.toolbar(.hidden, for: .navigationBar)
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
                
                TextField("Search the food", text: $searchText, onCommit: performSearch)
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
        .padding(.top, 10)
    }
}

struct FoodRow: View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    @Binding var showSnackbar: Bool
    @State private var isAddedToWishlist: Bool = false
    
    var index: Int
    var body: some View {
        
        let searchModel = viewModel.searchModels[index]
        let (icon, message) = viewModel.cautionDetails(for: index)
        let nutritionMessages = viewModel.nutritionMessages(for: index)
        
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
                HStack(spacing: 7){
                    Text("Sometime Possible")
                        .font(.Alert.alert)
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 5)
                        .background(Color.darkYellow)
                        .cornerRadius(4)
                    
                    Text("added over 20 people")
                        .font(.Alert.alert)
                        .foregroundColor(.black)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 5)
                        .background(Color.gray200)
                        .cornerRadius(4)
                    
                }
            }
            Spacer()
            
            Image(viewModel.selectedIndices.contains(index) ? "icon_check" : "icon_plus")
                .onTapGesture {
                    isAddedToWishlist.toggle()
                    showSnackbar.toggle()
                    viewModel.toggleSelection(for: index)
                    showSnackbar = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showSnackbar = false
                    }
                }
        }
        .frame(width: 313)
        .padding(.horizontal, 16)
        .padding(.vertical, 17)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.leading, 16)
        .padding(.trailing, 18)
        
    }
    
}


struct Snackbar: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(.iconWishcheck)
            
            Text("Added to your wishlist!")
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
//    Task {
//        // 검색 api 호출
//    }
}

//#Preview {
//    SearchView()
//}
