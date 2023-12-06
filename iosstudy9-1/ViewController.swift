//
//  ViewController.swift
//  iosstudy9-1
//
//  9주차 실습
//

import UIKit


class ViewController: UIViewController {
    
    let weatherURL = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
 
    struct weatherData: Codable {
        let response: Response
    }

    struct Response: Codable {
        let header: Header
        let body: Body
    }

    struct Body: Codable {
        let dataType: String
        let items: Items
        let pageNo, numOfRows, totalCount: Int
    }

    struct Items: Codable {
        let item: [Item]
    }

    struct Item: Codable {
        let regID: String
        let rnSt3Am, rnSt3Pm, rnSt4Am, rnSt4Pm: Int
        let rnSt5Am, rnSt5Pm, rnSt6Am, rnSt6Pm: Int
        let rnSt7Am, rnSt7Pm, rnSt8, rnSt9: Int
        let rnSt10: Int
        let wf3Am, wf3Pm, wf4Am, wf4Pm: String
        let wf5Am, wf5Pm, wf6Am, wf6Pm: String
        let wf7Am, wf7Pm, wf8, wf9: String
        let wf10: String

        enum CodingKeys: String, CodingKey {
            case regID = "regId"
            case rnSt3Am, rnSt3Pm, rnSt4Am, rnSt4Pm, rnSt5Am, rnSt5Pm, rnSt6Am, rnSt6Pm, rnSt7Am, rnSt7Pm, rnSt8, rnSt9, rnSt10, wf3Am, wf3Pm, wf4Am, wf4Pm, wf5Am, wf5Pm, wf6Am, wf6Pm, wf7Am, wf7Pm, wf8, wf9, wf10
        }
    }

    struct Header: Codable {
        let resultCode, resultMsg: String
    }
    
    func getData(){
        if let url = URL(string: weatherURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let JSONdata = data {
                    print(JSONdata, response!)
                    let dataString = String(data: JSONdata, encoding: .utf8)
                    print(dataString!)
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let decodedData = try decoder.decode(weatherData.self, from: JSONdata)
                        print(decodedData.response.body.items.item[0].wf3Am)
                        let weatherItem = decodedData.response.body.items.item[0].wf3Am
                        DispatchQueue.main.async {
                            sleep(1)
                            self.weatherLabel.text = weatherItem as? String
                            
                            if weatherItem as? String == "맑음" {
                                self.iconButton.setImage(UIImage(systemName: "sun.max.fill"), for: .normal)
                            }
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
   
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var iconButton: UIButton!
    
}

