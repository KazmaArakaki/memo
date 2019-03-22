``` swift
import UIKit

protocol ThetaStartSessionTaskDelegate {
    func thetaStartSessionTask(responseData: ThetaStartSessionTask.ResponseData)
    func thetaStartSessionTask(errorMessage: String)
}

class ThetaStartSessionTask: ThetaBaseTask {
    var delegate: ThetaStartSessionTaskDelegate? = nil
    
    struct ResponseData {
        let sessionId: String
    }
    
    override init() {
        super.init()
        
        _delegate = self
        _apiEndpoint = "/osc/commands/execute"
        _method = "POST"
        _timeoutInterval = 1.0

        data(key: "name", value: "camera.startSession")
    }
}

extension ThetaStartSessionTask: ThetaBaseTaskDelegate {
    func thetaBaseTask(responseData: Dictionary<String, Any?>) {
        guard
            let results: Dictionary = responseData["results"] as? Dictionary<String, Any?>,
            let sessionId: String = results["sessionId"] as? String
            else {
                delegate?.thetaStartSessionTask(errorMessage: "Failed to parse response data.")
                
                return
        }
        
        delegate?.thetaStartSessionTask(responseData: ResponseData(sessionId: sessionId))
    }
    
    func thetaBaseTask(errorMessage: String) {
        delegate?.thetaStartSessionTask(errorMessage: errorMessage)
    }
}
```
