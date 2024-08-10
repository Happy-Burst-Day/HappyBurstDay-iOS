//
//  MainView.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/11/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = WishListViewModel()
    
    var body: some View {
        SettingView()
        
        CustomTabView(
            views: [
                .one: AnyView(WishListView()),
                .two:  AnyView(MyBabyView())
            ],
            selection: $viewModel.selectedTab
        )
    }
}


struct SettingView: View {
    var body: some View {
        HStack {
            Text("BabyMomma")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 20)
            
            Spacer()
            
            Image(systemName: "gearshape")
                .font(.system(size: 20))
                .padding(.trailing, 24)
                .onTapGesture {

                    // 설정 이동

                }
        }
    }
}

struct WishListView: View {
    var body: some View {

        ZStack {
            Color.gray150
                .ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 0) {
                    TopView()
                    FoodWishView()
                    WishRow()
                    WishRow()
                }
                
            }
        }
    }
}

struct TopView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Top 3 Wish Foods")
                    .font(.Title.title2)
                    .foregroundColor(.customBlack)
                    .padding(.bottom, 7)
                    .padding(.leading, 22)
                    .padding(.top, 22)
                
                Text("Received the most hearts from mothers in the past week")
                    .font(.Alert.alert)
                    .foregroundColor(.gray800)
                    .padding(.bottom, 29)
                    .padding(.leading, 22)
                
                ImageCarouselView()
                    .padding(.bottom, 28)
            }
            
        }
        .frame(width: 350, height: 372)
        .background(.white)
        .cornerRadius(10)
        .padding(.top, 25)
        .padding(.bottom, 30)
    }
}

struct ImageCarouselView: View {
    let images: [String] = ["img_wish1", "img_wish2", "img_wish3"]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFit()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct FoodWishView: View {
    var body: some View {
        HStack {
            VStack(spacing: 6){
                Text("My Food Wishlist")
                    .font(.Title.title2)
                    .foregroundColor(.customBlack)
                
                Text("Search for any food you want,\nadd it to your wishlist,")
                    .font(.Alert.alert)
                    .foregroundColor(.gray800)
            }.padding(.leading, 21)
            
            Spacer()
            
            HStack(spacing: 5) {
                Image(systemName: "plus")
                    .font(.system(size: 12))
                    .foregroundColor(.white)

                Text("Add")
                    .font(.Body.body2)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 9)
            .padding(.horizontal, 11)
            .background(Color.customBlack)
            .cornerRadius(10)
            .padding(.trailing, 21)
        }
        .padding(.bottom, 25)
    }
}

struct WishRow: View {

    @State private var heartCount: Int = 0

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 3) {
                    Image(.iconCaution)
                    Text("Require Attention")
                        .font(.Alert.alert)
                        .foregroundColor(.customOrange)
                }
                
                HStack(spacing: 10) {
                    Text("Steak Rice Bowl")
                        .font(.Title.title3)
                        .foregroundColor(.customBlack)
                    
                    Text("430 kcal")
                        .font(.Body.body2)
                        .foregroundColor(.gray600)
                        .padding(.top, 4)
                }
                
                Text("Consume Frequently")
                    .font(.Alert.alert)

                    .foregroundColor(.white)

                    . foregroundColor(.white)

                    .padding(.vertical, 4)
                    .padding(.horizontal, 5)
                    .background(Color.darkMint)
                    .cornerRadius(4)
            }
            Spacer()
            
            VStack(spacing: 3){
                Image(systemName: "heart.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.customPink)
                    .onTapGesture {

                        heartCount += 1
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                Text("\(heartCount)")

                        
                    }
                Text("0")

                    .font(.system(size: 24))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 17)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.leading, 16)
        .padding(.trailing, 18)
        .padding(.bottom, 12)
    }
}


struct EmptyRowView: View {
    var body: some View {
        ZStack {
            Color.gray150
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                Image(systemName: "plus")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 11)
                    .background(Color.customBlack)
                    .cornerRadius(10)
                    .padding(.bottom, 21)
                
                Text("Your Wish List is Empty.\nPlease add your wish food.")
                    .font(.Alert.alert)
                    .foregroundColor(.gray600)
            }
        }
    }
}




struct MyBabyView: View {
    var body: some View {
        ZStack {
            Color.gray150
                .ignoresSafeArea()

            ScrollView{
                VStack(spacing: 0) {
                    BabyDayView()
                    NotEatListView()
                }
            }
        }
    }
}

struct BabyDayView: View {
    var body: some View {
        ZStack {
            Image(.imgBaby)
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .center) {
                Spacer()
                
                Text("D - 48")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                    .padding(.bottom, 30)
            }.frame(width: 352, height: 372)
        }
        .padding(.horizontal, 21)
        .padding(.top, 25)
        .padding(.bottom, 30)
    }
}

struct NotEatListView: View {
    var body: some View {
        Text("You Can Eat After 48 days")
            .font(.Title.title2)
            .foregroundColor(.black)
            .padding(.trailing, 100)
            .padding(.bottom, 25)
        
        NotEatRow()
        NotEatRow()
    }
}

struct NotEatRow: View {
    @State private var heartEatCount: Int = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 3) {
                    Image(.iconBan)
                    Text("Do not Consume")
                        .font(.Alert.alert)
                        .foregroundColor(.customOrange)
                }
                
                HStack(spacing: 10) {
                    Text("Steak Rice Bowl")
                        .font(.Title.title3)
                        .foregroundColor(.customBlack)
                    
                    Text("430 kcal")
                        .font(.Body.body2)
                        .foregroundColor(.gray600)
                        .padding(.top, 4)
                }
                
                Text("Available after 48 days")
                    .font(.Alert.alert)
                    .foregroundColor(.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 5)
                    .background(Color.darkPink)
                    .cornerRadius(4)
            }
            Spacer()
            
            VStack(spacing: 3){
                Image(systemName: "heart.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.customPink)
                    .onTapGesture {
                        heartEatCount += 1
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                Text("\(heartEatCount)")
                    .font(.system(size: 24))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 17)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.leading, 16)
        .padding(.trailing, 18)
        .padding(.bottom, 12)
    }
}



#Preview {
    MainView()
}
