//
//  TODOListFetchWorker.swift
//  TODOList
//
//  Created by Vishal Khokad on 22/06/24.
//

import UIKit

protocol TODOListFetchWorkerProtocol {
    func fetchData(_ completion: @escaping (_ data: [TODOResponseModel]) -> Void)
}

class TODOListFetchWorker: TODOListFetchWorkerProtocol {
    
    func fetchData(_ completion: @escaping (_ data: [TODOResponseModel])-> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos?userId=1")!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            do {
                if let todoList = data {
                    let decodedData = try JSONDecoder().decode([TODOResponseModel].self, from: todoList)
                    print(decodedData)
                    
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                } else {
                    print("No data found!")
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }

}
