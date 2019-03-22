``` swift
import UIKit

protocol ThetaBaseTaskDelegate {
    func thetaBaseTask(responseData: Dictionary<String, Any?>)
    func thetaBaseTask(errorMessage: String)
}

extension ThetaBaseTaskDelegate {
    func thetaBaseTask(responseData: Dictionary<String, Any?>) {}
    func thetaBaseTask(errorMessage: String) {}
}

class ThetaBaseTask: NSObject {
    var _delegate: ThetaBaseTaskDelegate? = nil
    var _apiFullUrl: String = ""
    var _apiBaseUrl: String = "http://192.168.1.1"
    var _apiEndpoint: String = ""
    var _method: String = "POST"
    var _requestData: Dictionary<String, Any?> = [:]
    var _dataTask: URLSessionDataTask? = nil
    var _timeoutInterval: Double = -1.0
    
    deinit {
        _dataTask?.cancel()
    }
    
    func start() {
        if (_dataTask == nil) {
            let url: URL = (_apiFullUrl.isEmpty ? URL(string: _apiBaseUrl + _apiEndpoint) : URL(string: _apiFullUrl))!
            var request: URLRequest = URLRequest(url: url)
            
            do {
                request.httpMethod = _method
                
                if _method == "POST" {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = try JSONSerialization.data(withJSONObject: _requestData, options: .prettyPrinted)
                }
                
                if _timeoutInterval > 0 {
                    request.timeoutInterval = _timeoutInterval
                }
            } catch {
                _delegate?.thetaBaseTask(errorMessage: "Failed to init URLRequest.")
                
                return
            }

            
            _dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error: Error = error {
                    self._delegate?.thetaBaseTask(errorMessage: error.localizedDescription)

                    return
                }

                do {
                    guard let data: Data = data else {
                        self._delegate?.thetaBaseTask(errorMessage: "Failed to read Data.")

                        return
                    }

                    if let responseData: Dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any?> {
                        self._delegate?.thetaBaseTask(responseData: responseData)
                        
                        return
                    }
                    
                    self._delegate?.thetaBaseTask(errorMessage: "Unexpected Error.")
                } catch {
                    self._delegate?.thetaBaseTask(errorMessage: "Failed to parse JSON.")
                }
            }

            _dataTask?.resume()
        }
    }
    
    func data(key: String, value: String) {
        _requestData[key] = value
    }
    
    func data(key: String, value: Int) {
        _requestData[key] = value
    }
    
    func data(key: String, value: Dictionary<String, Any?>) {
        _requestData[key] = value
    }
}
```
