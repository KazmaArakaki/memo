``` swift
import Foundation
import UIKit

protocol ThetaGetLivePreviewTaskDelegate {
    func thetaGetLivePreviewTask(responseData: ThetaGetLivePreviewTask.ResponseData)
    func thetaGetLivePreviewTask(errorMessage: String)
}

class ThetaGetLivePreviewTask: ThetaBaseTask {
    var delegate: ThetaGetLivePreviewTaskDelegate? = nil

    private let startMarker: Data = Data(bytes: [0xFF, 0xD8])
    private let endMarker: Data = Data(bytes: [0xFF, 0xD9])
    private var dataBuffer: Data = Data()

    var interval: UInt32 = 5

    struct ResponseData {
        let image: UIImage
    }

    override init() {
        super.init()

        _apiEndpoint = "/osc/commands/execute"
        _method = "POST"
        _timeoutInterval = 60.0

        data(key: "name", value: "camera.getLivePreview")
    }

    override func start() {
        if (_dataTask == nil) {
            let session: URLSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            let url: URL = URL(string: _apiBaseUrl + _apiEndpoint)!
            var request: URLRequest = URLRequest(url: url)

            do {
                request.httpMethod = _method
                request.timeoutInterval = _timeoutInterval
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONSerialization.data(withJSONObject: _requestData, options: .prettyPrinted)
            } catch {
                delegate?.thetaGetLivePreviewTask(errorMessage: "Failed to init URLRequest.")
            }

            _dataTask = session.dataTask(with: request)

            _dataTask?.resume()
        }
    }
}

extension ThetaGetLivePreviewTask: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        dataBuffer.append(data)

        guard var dataBuffer: NSMutableData = (dataBuffer as NSData).mutableCopy() as? NSMutableData else {
            return
        }

        let endRange: NSRange = dataBuffer.range(of: endMarker, options: [], in: NSMakeRange(0, dataBuffer.length))
        let endLocation = endRange.location + endRange.length

        if dataBuffer.length >= endLocation {
            let imageData = dataBuffer.subdata(with: NSMakeRange(0, endLocation))

            if let image: UIImage = UIImage(data: imageData) {
                self.delegate?.thetaGetLivePreviewTask(responseData: ResponseData(image: image))
            }

            dataBuffer = NSMutableData(data: dataBuffer.subdata(with: NSMakeRange(endLocation, dataBuffer.length - endLocation)))

            self.dataBuffer = dataBuffer as Data
        }
    }
}
```
