//
//  ViewController.swift
//  StarWarsPeople
//
//  Created by Lauren Small on 11/26/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    var people: [String] = []
    
    
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchPeople()
    }


    func peopleURL() -> URL {
        let urlString = "https://swapi.co/api/people/"
        let url = URL(string: urlString)
        return url!
}
    
    
    func fetchPeople()  {
        let url = peopleURL()
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            //parse array of URLs
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            let root = try! decoder.decode(Results.self, from: data)
            let allJsonData = root.results
            allJsonData.forEach() { print($0.name)
                self.people.append($0.name) }
            print("The people array is: \(self.people)")
        }
        dataTask.resume()
    }
    
    
    func parse(data: Data) -> Results? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Results.self, from: data)
            
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
}
