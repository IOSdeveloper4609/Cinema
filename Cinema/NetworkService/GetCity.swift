//
//  GetCity.swift
//  Cinema
//
//  Created by Азат Киракосян on 10.01.2021.
//

import Foundation

final class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getCity(api: String, completion: @escaping ([City]) -> Void) {
        let urlString = api
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { ( data, _, error ) in
            guard let data = data else { return }
            guard error == nil else { return }

            do {
                let results = try JSONDecoder().decode([City].self, from: data)

                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print("Json Error")
            }
        } .resume()
    }

}
