//
//  ListingView.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Combine
import SwiftUI
import struct Kingfisher.KFImage

struct ListingView: View {
    
    @ObservedObject var listingVM = ListingVM()
        
    @EnvironmentObject var removedData: RemovedDataPublisher
    
    @State var isRemovedData: Bool = false
    
    @State var isShowAlert: Bool = false
    
    private var gridItemLayout = [GridItem(.flexible())]
    
    var btnSort : some View {
        
        Menu {
            SortButton(sortType: .all, listingVM: listingVM)
            SortButton(sortType: .text, listingVM: listingVM)
            SortButton(sortType: .image, listingVM: listingVM)
            SortButton(sortType: .other, listingVM: listingVM)
        } label: {
            Text("Sort By:")
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach(listingVM.data, id: \.id) { object in
                        
                        NavigationLink(destination:
                            DetailsView(item: object)
                                .onDisappear {
                                    if self.isRemovedData {
                                        self.isRemovedData = false
                                        self.isShowAlert = true
                                        //self.listingVM.removedDataFromDetailsVC(self.removedData.item!)
                                    }
                                }
                                .onReceive(removedData.objectWillChange) {
                                    self.isRemovedData = true
                                }
                        ) {
                            HStack {
                    
                                if object.type == "image" {
                                    KFImage(URL(string: object.data))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(minWidth: 0, maxWidth: 100, maxHeight: 80)
                                        .cornerRadius(10)
                                }
                                
                                Spacer()
                                
                                ListingTextViews(item: object)
                            }
                        }
                    }
                    .padding([.leading, .bottom, .trailing], 10.0)
                }
            }
            /*.alert(isPresented: $isRemovedData) {
                Alert(title: Text("Removed: " + (self.removedData.item?.id ?? "None")),
                      message: Text(self.removedData.item?.data ?? "RR"),
                                  dismissButton: .default(Text("OK")))
            }*/
            .actionSheet(isPresented: $isShowAlert) {
                ActionSheet(title: Text("Will Remove: " + (self.removedData.item?.id ?? "None" + "?")),
                            message: Text(self.removedData.item?.data ?? "RR"), buttons: [.default(Text("OK"), action: {
                                self.listingVM.removedDataFromDetailsVC(self.removedData.item!)
                            })])
            }
            .navigationBarTitle(ViewTitle.Name.listingVC)
            .navigationBarItems(trailing: btnSort)
        }
    }
}


struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView().environmentObject(RemovedDataPublisher())
    }
}
