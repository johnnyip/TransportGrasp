//
//  Help_siriShortcut.swift
//  Help_siriShortcut
//
//  Created by Johnny on 21/8/2021.
//

import SwiftUI

struct Help_siriShortcut: View {
    @Binding var showSheet:Bool
    
    var body: some View {
        ZStack{
            VStack{
            HStack{
                Spacer()
                Button("Close"){
                    self.showSheet = false
                }
                .buttonStyle(SmallButton())
            }.padding([.trailing,.leading,.top],5)

            ScrollView{
                
                Group{
                Text("加喜愛路線")
                Image("help_1")
                    .resizable()
                    .scaledToFit()
                Divider()                        .padding()

                Text("打開Apple捷徑App")
                Image("help_2")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal,30)
                Divider()                        .padding()

                }
                Group{
                Text("選擇自動化 -> 新增 -> 製作自動化操作")
                HStack{
                    Image("help_3")
                        .resizable()
                        .scaledToFit()
                    Image("help_4")
                        .resizable()
                        .scaledToFit()
                }
                
                Divider()
                Text("選擇「抵達」-> 設定提示區域，更可以指定時間")
                    HStack{
                        Image("help_5")
                            .resizable()
                            .scaledToFit()
                        Image("help_6")
                            .resizable()
                            .scaledToFit()
                }
                    Divider()                        .padding()

                }
                
                Group{
                    Text("選擇「加入動作」->點選「建議」\n如沒有出現，先選擇App->「TransGrasp」->「Get ETA...」")
                    Image("help_7")
                        .resizable()
                        .scaledToFit()
                    Image("help_8")
                        .resizable()
                        .scaledToFit()
                    Divider()
                        .padding()
                }
                Group{
                    Text("「顯示更多資料」->選擇喜愛路線(App頁顯示的順序號碼)->選擇「執行時顥示」\n按下右下角測試。如彈出視窗，按下允許權限\n「下一步」->「完成」儲存")
                    Image("help_9")
                        .resizable()
                        .scaledToFit()
                    Image("help_10")
                        .resizable()
                        .scaledToFit()
                    Divider()
                        .padding()
                }
                
                Group{
                    Text("受限於Apple系統，每次到達時會彈出下面通知，須按下「執行」方會彈出到站資訊")
                    Image("help_11")
                        .resizable()
                        .scaledToFit()
                    Image("help_12")
                        .resizable()
                        .scaledToFit()
                    Divider()
                }


                Spacer()
            }
            .padding(.horizontal)
        }
        }
    }
}

