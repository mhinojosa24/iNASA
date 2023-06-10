//
//  ViewController.swift
//  iNASA
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://images-api.nasa.gov/search?q=shoes&media_type=image") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                print("OOPS ERROR: \(error.localizedDescription)")
                return
            }
            
            if let data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}
