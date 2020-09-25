//
//  CustomViews.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 25/09/20.
//

import SwiftUI

struct SortButton: View {
            
    var sortType: RRSortEnum
    var listingVM: ListingVM
    
    var body: some View {
        Button(action: {
            let data = RRDataModel.sortBy(sortType)
            if (data?.count ?? 0) > 0 {
                self.listingVM.data.removeAll()
                self.listingVM.data.append(contentsOf: data!)
            }
        }) {
            Text(sortType.title)
        }
    }
}

struct ListingTextViews: View {
    
    let item: RRDataModel
    
    var body: some View {
        VStack {
            HStack {
                
                VStack (alignment: .leading, spacing: 5) {
                    Text(item.id)
                        .modifier(ListingTextModifier())
                    
                    
                    if item.type == "text" {
                        Text(item.data)
                            .modifier(ListingTextModifier(fontSize: 14))
                            .lineLimit(3)
                        
                        Spacer()
                    }
                }
                        
                Spacer()
                
                VStack (alignment: .trailing, spacing: 5) {
                    Text(item.type.capitalized)
                        .modifier(ListingTextModifier(fontSize: 14, color: .red))
                    
                    Spacer()
                    
                    Text(item.date)
                        .modifier(ListingTextModifier(fontSize: 12))
                }
            }
        }
    }
}
