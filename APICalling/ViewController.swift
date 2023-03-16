//
//  ViewController.swift
//  APICalling
//
//  Created by Sneh kalariya on 16/03/23.
//

import UIKit

struct GetApi: Codable{
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class ViewController: UIViewController {

    var getApiArray: [GetApi] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        var ur = URLRequest(url: url!)
        ur.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: ur){data,response,error in
            do{
                if error == nil {
                    self.getApiArray = try JSONDecoder().decode([GetApi].self, from: data!)
                    print(self.getApiArray)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
