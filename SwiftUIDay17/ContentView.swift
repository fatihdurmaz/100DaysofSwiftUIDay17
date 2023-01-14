//
//  ContentView.swift
//  SwiftUIDay17
//
//  Created by Fatih Durmaz on 13.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var hesap = 0.0
    @State private var kisiSayisi = 2
    @FocusState private var klavyeGizle: Bool
    var kisiler = Array(2...15) // 2 ve 15 dahil olacak şekilde dizi oluşturduk.
    @State private var bahsisYuzdesi = 20
    let bahsisYuzdeleri = [10,15,20,25,30]
    
    var kisiBasiHesap: Double {
        let bahsisTutari = hesap / 100 * Double(bahsisYuzdesi)
        let bahsisDahilHesap = hesap + bahsisTutari
        let kisiBasiHesap = bahsisDahilHesap / Double(kisiSayisi)
        return kisiBasiHesap
    }
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    TextField("Toplam Tutar",value: $hesap, format: .currency(code:Locale.current.currency?.identifier ?? "TRY"))
                        .keyboardType(.decimalPad)
                        .focused($klavyeGizle)
                    /*
                     1) Textfield kontrol elemanının formatını değiştirmek için format: özelliğini kullanırız. (Sıcaklık, para birimi vb.)
                     2) Klavye tipini değiştirmek için keyboardType() kullanırız.
                     */
                    
                    Picker("Kişi Sayısı", selection: $kisiSayisi){
                        ForEach(kisiler, id: \.self){row in
                            // Diziyi foreach'a veri kaynağı olarak verince, Picker her bir indisdeki değeri, dizide karşılık gelen elemanın değerine eşitleyerek işlem yapar.
                            HStack {
                                Text("\(row) kişi")
                                Image(systemName: "person")
                            }
                        }
                    }
                }
                Section{
                    Picker("Bahşis Yüzdesi", selection: $bahsisYuzdesi) {
                        ForEach(bahsisYuzdeleri, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented) // Picker'ın tipini pickerStyle() ile berlirleriz.
                } header: {
                    Text("Ne Kadar (%) Bahşiş Vermek İsterseniz?")
                }
                
                Section{
                    Text(kisiBasiHesap, format:.currency(code: Locale.current.currency?.identifier ?? "TRY"))
                        .fontWeight(.bold)
                    /*
                     1) iOS 16 ile current.currencyCode deprecated edilmiştir. current.currency?.identifier kullanıyoruz artık.
                     */
                }
            }.navigationTitle("Alman Usülü")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) { // toolbarın klavye konumuna ekleneceğini placement etiketi ile söyleriz.
                        Button("Tamam") {
                            klavyeGizle = false
                        }
                        /*
                         Klavyenin üst tarafındaki bir toolbar öğesine bir buton ekleyip; butonun action olayında, klavyenin gizlenmesi için gerekli değişkeni false yapar.
                         */
                        
                    }
                }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
