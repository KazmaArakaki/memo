``` swift
import UIKit

protocol ThetaGetStateTaskDelegate {
    func thetaGetStateTask(responseData: ThetaGetStateTask.ResponseData)
    func thetaGetStateTask(errorMessage: String)
}

class ThetaGetStateTask: ThetaBaseTask {
    var delegate: ThetaGetStateTaskDelegate? = nil

    struct ResponseData {
        let apiVersion: Int
    }

    override init() {
        super.init()

        _delegate = self
        _apiEndpoint = "/osc/state"
        _method = "POST"
        _timeoutInterval = 1.0
    }
}

extension ThetaGetStateTask: ThetaBaseTaskDelegate {
    func thetaBaseTask(responseData: Dictionary<String, Any?>) {
        guard
            let state: Dictionary = responseData["state"] as? Dictionary<String, Any?>,
            let apiVersion: Int = state["_apiVersion"] as? Int
        else {
            delegate?.thetaGetStateTask(errorMessage: "Failed to parse response data.")

            return
        }

        delegate?.thetaGetStateTask(responseData: ResponseData(apiVersion: apiVersion))
    }
    
    func thetaBaseTask(errorMessage: String) {
        delegate?.thetaGetStateTask(errorMessage: errorMessage)
    }
}
```
