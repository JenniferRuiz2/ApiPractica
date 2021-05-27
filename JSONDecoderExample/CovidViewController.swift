//
//  CovidViewController.swift
//  JSONDecoderExample
//
//  Created by Ramiro y Jennifer on 24/05/21.
//

import UIKit

struct CovidApi: Codable{
    var country: String
    var cases: Int
}


class CovidViewController: UIViewController{
    
    var covid = [CovidApi]()
    

    @IBOutlet weak var tablaCovid: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                print("Listo para llamar a parse!")
             parseJson(json: data)
                print("Data:\(data) ")
            }

        }
        
    }
    
    func parseJson(json: Data){
        let decoder = JSONDecoder()
        print("Se llamo parse y creo decoder")
        print("JSON: \(json)")
        let jsonPeticion = try? decoder.decode([CovidApi].self, from: json)
        //print("Peticion: \(jsonPeticion!)")
        covid = jsonPeticion!
        print("Casos covid: \(covid)")
        tablaCovid.reloadData()
        
        
    }
    
}

extension CovidViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaCovid.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = covid[indexPath.row].country
        celda.detailTextLabel?.text = "\(covid[indexPath.row].cases)"
        return celda
    }
}
