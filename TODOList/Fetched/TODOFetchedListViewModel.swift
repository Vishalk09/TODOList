//
//  TODOFetchedListViewModel.swift
//  TODOList
//
//  Created by Vishal Khokad on 22/06/24.
//

import Foundation

class TODOFetchedListViewModel {
    
    let worker = TODOListFetchWorker()

    func fetchData(_ completion: @escaping (_ data: [TODOResponseModel]) -> Void) {
        worker.fetchData() { data in
            completion(data)
        }
    }
}
