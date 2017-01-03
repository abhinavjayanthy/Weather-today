//
//  ViewController.swift
//  Weather today
//
//  Created by Abhinav Jayanthy on 1/2/17.
//  Copyright © 2017 Abhinav Jayanthy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cityName: UITextField!
    @IBOutlet var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitButton(_ sender: Any) {
        var message = ""
        if let url = URL(string :"http://www.weather-forecast.com/locations/\(cityName.text!.replacingOccurrences(of: " ", with: "-"))/forecasts/latest"){
        let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data,response,error in
                
                if (error != nil){
                    print(error!)
                }
                else{
                    if let unwrappedData = data{
                        let dataString = NSString(data: unwrappedData, encoding:String.Encoding.utf8.rawValue )
                        var stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        if let contentArray =  dataString?.components(separatedBy: stringSeperator){
                            if (contentArray.count > 1){
                                stringSeperator = "</span>"
                                
                               let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                                    
                                    if (newContentArray.count > 1){
                                        message =  String(newContentArray[0].replacingOccurrences(of: "&deg", with: "°"))
                                    }
                            }
                        }
                    }
                    if (message == "" ){
                        message = "Could not be found please try again "
                    }
                    DispatchQueue.main.sync(execute: {
                        self.resultLabel.text = message
                    })
                
                }
            }
        task.resume()
        }
        else{
            resultLabel.text = "Could not be found please try again "
        }
    }
}
