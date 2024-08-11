//
//  SettingView.swift
//  HappyBurstDay
//
//  Created by Geunhye on 8/11/24.
//

import SwiftUI

struct SettingView: View {
    
    @State private var dueDate = Date()

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                    Section(header: Header()) {
                        Group {
                            Text("Email")
                                .font(.Body.body2)
                                .foregroundColor(.gray)
                                .padding(.bottom, 14)
                            
                            Text("cracker123@gmail.com")
                                .font(.Body.body1)
                                .padding(.bottom, 40)
                            
                            Text("Due Date")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.bottom, 14)
                            DatePicker("", selection: $dueDate, displayedComponents: .date)
                                .labelsHidden()
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }

            Button(action: {
            }) {
                Text("Sign Out")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }.toolbar(.hidden, for: .navigationBar)
        .clipped()
    }
}

struct Header: View {
    var body: some View {
        HStack(spacing: 21) {
            Button(action: {
            }) {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 17))
                    .foregroundColor(.black)
            }
            Text("Setting")
                .font(.Title.title1)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(Color.white)
    }
}

#Preview {
    SettingView()
}
