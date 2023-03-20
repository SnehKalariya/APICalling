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

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var getApiArray: [GetApi] = []
    
    @IBOutlet weak var dataTable: UITableView!
    
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
//                    print(self.getApiArray)
                    DispatchQueue.main.async {
                        self.dataTable.reloadData()
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getApiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.label1.text = "\(getApiArray[indexPath.row].id)"
        cell.label2.text = getApiArray[indexPath.row].body
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
