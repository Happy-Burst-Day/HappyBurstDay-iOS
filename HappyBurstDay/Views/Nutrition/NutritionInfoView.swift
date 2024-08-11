//
//  NutritionInfoView.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/11/24.
//

import SwiftUI

struct NutritionInfoView: View {
    var body: some View {
        ZStack{
            Color.gray100
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    VStack(alignment: .leading) {
                        Text("Kimchi Fried Rice")
                            .font(.Title.title1)
                        
                        HStack(spacing: 3) {
                            Image(.iconCaution)
                            Text("Require Attention")
                                .font(.Body.body2)
                                .foregroundColor(.customOrange)
                        }
                        
                        HStack(spacing: 7){
                            
                            Text("essential nutrients")
                                .font(.Alert.alert)
                                .foregroundColor(.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 5)
                                .background(Color.darkMint)
                                .cornerRadius(4)
                            
                            Text("added over 20 people")
                                .font(.Alert.alert)
                                .foregroundColor(.black)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 5)
                                .background(Color.gray200)
                                .cornerRadius(4)
                        }.padding(.bottom, 27)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: 353, height: 230)
                    .overlay {
                        VStack (spacing: 0){
                            Text("430 kcal")
                                .font(.Headline.headline)
                            
                            Text("1 serving (300g)")
                                .font(.Body.body2)
                                .foregroundColor(.gray600)
                                .padding(.bottom, 37)
                            
                            HStack{
                                HStack(spacing: 20) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(.lightYellow)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 25)
                                        .overlay {
                                            Text("Vitamin C")
                                                .font(.Alert.alert)
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 10)
                                        }
                                    
                                    HStack(spacing: 7){
                                        Text("15")
                                            .font(.Body.body2)
                                        
                                        Text("mg")
                                            .font(.Alert.alert)
                                    }
                                }
                                
                                HStack(spacing: 20) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(.lightYellow)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 25)
                                        .overlay {
                                            Text("Iron")
                                                .font(.Alert.alert)
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 10)
                                        }
                                    
                                    HStack(spacing: 7){
                                        Text("15")
                                            .font(.Body.body2)
                                        
                                        Text("mg")
                                            .font(.Alert.alert)
                                    }
                                }
                            }
                            .padding(.bottom, 25)
                            
                            HStack{
                                HStack(spacing: 20) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(.lightYellow)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 25)
                                        .overlay {
                                            Text("Calcium")
                                                .font(.Alert.alert)
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 10)
                                        }
                                    
                                    HStack(spacing: 7){
                                        Text("15")
                                            .font(.Body.body2)
                                        
                                        Text("mg")
                                            .font(.Alert.alert)
                                    }
                                }
                                
                                HStack(spacing: 20) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(.lightYellow)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 25)
                                        .overlay {
                                            Text("Protein")
                                                .font(.Alert.alert)
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 10)
                                        }
                                    
                                    HStack(spacing: 7){
                                        Text("15")
                                            .font(.Body.body2)
                                        
                                        Text("mg")
                                            .font(.Alert.alert)
                                    }
                                }
                            }
                        }
                    }.padding(.bottom, 38)
                
                Text("🤰🏻 👼🏻 Key Points")
                    .font(.Title.title2)
                    .padding(.trailing, 200)
                    .padding(.bottom, 14)
                
                PointRow()
                PointRow()
            }
        }
    }
}

struct PointRow: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .frame(width: 353, height: 90)
            .overlay {
                HStack{
                    Circle()
                        .foregroundColor(.darkMint)
                        .frame(width: 35)
                        .overlay {
                            Text("👍🏻")
                        }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Vitamin C very Good")
                            .font(.Title.title3)
                            .padding(.bottom, 4)
                        Text("Vitamin C")
                            .font(.Alert.alert)
                    }
                    .padding(.horizontal, 14)
                    Spacer()
                }.padding(.horizontal, 20)
            }
    }
}

#Preview {
    NutritionInfoView()
}
