``` swift
import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView?
    var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = URLRequest(url: URL(string: "https://api.arakaki.app/test.json")!)
        request.httpMethod = "POST"
        request.httpBody = ("data=hoge").data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    print(try JSONSerialization.jsonObject(with: data, options: []))
                }
                catch let exception {
                    print(exception)
                }
            }
        }
        
        task.resume()
    }
}
```

or

``` swift
import UIKit

class ViewController: UIViewController, URLSessionDataDelegate {
    var imageView: UIImageView?
    var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = URLRequest(url: URL(string: "https://api.arakaki.app/test.json")!)
        request.httpMethod = "POST"
        request.httpBody = ("data=hoge").data(using: .utf8)
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        session.dataTask(with: request).resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        do {
            print(try JSONSerialization.jsonObject(with: data, options: []))
        }
        catch let exception {
            print(exception)
        }
    }
}
```
