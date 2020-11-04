//
//  ViewController.swift
//  StockUpdate
//
//  Created by Lakshmi on 03/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController {

    
    let apiKey = "a20e698b4b12f0266c0625b4dec3aeb6"
    
    let apiURL = "https://financialmodelingprep.com/api/v3/profile/"
    
    @IBOutlet weak var txtStockName: UITextField!
    
    @IBOutlet weak var CEOname: UILabel!
    
    @IBOutlet weak var lblStockValue: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getStockvalue(_ sender: Any) {
        guard let stockName = txtStockName.text?.uppercased() else { return }
        
        let url = "\(apiURL)\(stockName)?apikey=\(apiKey)"
        
        SwiftSpinner.show("Getting Stock Value")
        Alamofire.request(url).responseJSON{(response) in
            SwiftSpinner.hide()
            if response.result.isSuccess{
                guard let jsonString = response.result.value else { return }
                guard let stockJSON: [JSON] = JSON(jsonString).array else { return }
                
                if stockJSON.count < 1 { return }
                guard let ceo = stockJSON[0]["ceo"].rawString() else {return }
                guard let price = stockJSON[0]["price"].double else { return }
                self.lblStockValue.text = "\(price)"
                self.CEOname.text = "\(ceo)"
            }
        }
    }
    

}

