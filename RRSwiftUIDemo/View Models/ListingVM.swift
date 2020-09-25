//
//  ListingVM.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Combine
import SwiftUI
import RxSwift

class RemovedDataPublisher: ObservableObject {
    @Published var item: RRDataModel? = nil
}

class ListingVM : ObservableObject {
    @Published var data = [RRDataModel]()

    private let rxbag = DisposeBag()
    
    init() {
        getDataFromLocalDBOrServer(true)
    }
    
    private func getDataFromServer(_ isLoading: Bool = false) {
        
        APIManager.shared.setURL(APIEndPoint.Name.axxessTech)
        .showIndicator(isLoading)
        .setDeferredAsObservable()
        .subscribeConcurrentBackgroundToMainThreads()
        .subscribe(onNext: { [weak self] (response) in
            print(response)
            guard let self = self else { return }
            do {
                _ = try RRDataModel.create(from: response as! [[String : Any]])
                self.getDataFromLocalDBOrServer()
            } catch {
                UIAlertController.showAlert(title: nil, message: error.localizedDescription)
            }
        }, onError: { (error) in
            UIAlertController.showAlert(title: nil, message: error.localizedDescription)
        }).disposed(by: rxbag)
    }
    
    public func getDataFromLocalDBOrServer(_ isAPICall: Bool = false) {
        
        self.data.removeAll()
        
        var isLoding = true
        let data = RealmManager.shared.realm!.objects(RRDataModel.self)
        if data.count > 0 {
            // refresh list view and bind data
            self.data.append(contentsOf: data)
            isLoding = false
        }
        // Get data from server
        if isAPICall {
            getDataFromServer(isLoding)
        }
    }
    
    public func removedDataFromDetailsVC(_ data: RRDataModel) {
        //UIAlertController.showAlert(title: "Removed: " + data.id, message: data.data)
        self.data.remove(at: self.data.firstIndex(of: data)!)
        RRDataModel.removeDataObject(data)
    }
}
