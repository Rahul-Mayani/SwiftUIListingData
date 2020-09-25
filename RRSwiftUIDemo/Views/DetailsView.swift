//
//  DetailsView.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Combine
import SwiftUI
import struct Kingfisher.KFImage

struct DetailsView: View {
    
    let item: RRDataModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var removedData: RemovedDataPublisher
    
    var btnRemove : some View {
        Button(action: {
            self.removedData.item = item
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Remove")
        }
    }
    
    var body: some View {
        ScrollView {
            
            VStack (alignment: .leading, spacing: 10) {
                if item.type == "image" {
                    KFImage(URL(string: item.data))
                        .resizable()
                        .aspectRatio(1.75,contentMode: .fill)
                } else {
                    Spacer()
                }
                
                HStack {
                    Text(item.type.capitalized)
                        .foregroundColor(.red)
                        .modifier(DetailsTextModifier(fontSize: 16))
                    
                    Spacer()
                    
                    Text(item.date)
                        .modifier(DetailsTextModifier(padding: .trailing, alignment: .trailing))
                }
                                
                if item.type == "text" {
                    Text(item.data)
                        .modifier(DetailsTextModifier(fontSize: 17, padding: .horizontal))
                }
            }
        }
        .navigationBarTitle(item.id, displayMode: .inline)
        .navigationBarItems(trailing: btnRemove)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let data = RealmManager.shared.realm!.objects(RRDataModel.self)
        NavigationView {
            DetailsView(item: data.first!)
        }
    }
}
