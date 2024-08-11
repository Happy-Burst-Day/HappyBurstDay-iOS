//
//  BirthDateView.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import SwiftUI

struct BirthDateView:View {
    @Environment(\.navigationControllerState) var naviState
    @State var changeDate = false
    @State var birthDate = Date()
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    VStack(alignment:.leading,spacing: 15){
                        Text("Please let me know")
                        Text("the expected due date")
                    }.font(.pretendard(weight: .medium, size: 24))
                    Spacer()
                }.padding(.top,80).padding(.leading,20)
                Spacer()
                VStack(spacing: 58){
                    Image(.baby).resizable().scaledToFit().padding(.horizontal,50)
                    ZStack{
                        
                        Button{
                            changeDate = true
                        }label: {
                            VStack{
                                Text(formatDateToMMMddyyyy).font(.pretendard(weight: .medium, size: 24))
                                    .foregroundStyle(.black)
                                Spacer()
                                Text("press to change").font(.Body.body2).foregroundStyle(.gray400)
                            }.padding(.vertical,17)
                                .padding(.horizontal,55)
                                .background{
                                    RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).fill(.darkMint)
                                }
                        }.frame(height: 81)
                        
                        
                    }.sheet(isPresented: $changeDate, content: {
                        DatePickerSheet(selectedDate: Date()) { date in
                            self.birthDate = date
                            changeDate = false
                        }.presentationDetents([.medium]).presentationCornerRadius(12).presentationDragIndicator(.visible)
                    })
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    HStack{
                        Spacer()
                        Text("Start Mommy...").font(.Title.title2).foregroundStyle(.white)
                        Spacer()
                    }.frame(height: 68).background(.darkMint).tint(.darkMint)
                })
            }
        }
        
        .toolbar(.hidden, for: .navigationBar)
        .onAppear(){
            naviState.allowsSwipeBack = false
        }
    }

    var formatDateToMMMddyyyy : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // 영어 형식으로 표시하도록 설정
        return dateFormatter.string(from: self.birthDate)
    }
}
struct DatePickerSheet:View {
    @State private var selectedDate:Date
    var completeAction:(Date) -> ()
    init(selectedDate: Date, completeAction: @escaping (Date) -> Void) {
        self._selectedDate = .init(wrappedValue: selectedDate)
        self.completeAction = completeAction
    }
    var body: some View {
        VStack (spacing:4){
            Rectangle().fill(.clear).frame(maxHeight:24)
            DatePicker("",selection: $selectedDate, displayedComponents: [.date])
                .tint(.darkMint)
                .datePickerStyle(GraphicalDatePickerStyle())
            //            TRView.CompleteButton {
            //                completeAction(selectedDate)
            //            }
            Button(action: {
                completeAction(selectedDate)
            }, label: {
                HStack{
                    Spacer()
                    Text("Completed").font(.pretendard(weight: .medium, size: 16))
                    Spacer()
                }
                
                .padding(.vertical,16)
                .background(.darkMint).foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal,20)
                
            })
        }.padding(.bottom,24)
    }
}
