``` swift
import UIKit

protocol ThetaSetOptionsTaskDelegate {
    func thetaSetOptionsTask(responseData: ThetaSetOptionsTask.ResponseData)
    func thetaSetOptionsTask(errorMessage: String)
}

class ThetaSetOptionsTask: ThetaBaseTask {
    var delegate: ThetaSetOptionsTaskDelegate? = nil

    struct ResponseData {
        let success: Bool
    }

    override init() {
        super.init()

        _delegate = self
        _apiEndpoint = "/osc/commands/execute"
        _method = "POST"
        _timeoutInterval = 1.0

        data(key: "name", value: "camera.setOptions")
    }
}

extension ThetaSetOptionsTask: ThetaBaseTaskDelegate {
    func thetaBaseTask(responseData: Dictionary<String, Any?>) {
        delegate?.thetaSetOptionsTask(responseData: ResponseData(success: true))
    }

    func thetaBaseTask(errorMessage: String) {
        delegate?.thetaSetOptionsTask(errorMessage: errorMessage)
    }
}
```
