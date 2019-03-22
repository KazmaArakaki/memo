``` swift
import UIKit
import SceneKit

class MainViewController: UIViewController {
    @IBOutlet weak var sceneViewer: SCNView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var thetaTask: ThetaBaseTask? = nil

    private var scene: SCNScene = SCNScene()
    private var camera: Camera = Camera()
    private var sphere: Sphere = Sphere()

    private var sphreImage: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneViewer.debugOptions = .showWireframe
        sceneViewer.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(sceneViewerPanGestureHandler(_:))))

        activityIndicator.stopAnimating()
        statusLabel.text = ""

        initScene()
        startLivePreview()
    }

    func initScene() {
        scene.rootNode.addChildNode(camera.node)
        scene.rootNode.addChildNode(sphere.node)

        let lightNode: SCNNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .ambient
        lightNode.light?.color = UIColor.white

        scene.rootNode.addChildNode(lightNode)

        sceneViewer.scene = scene
    }

    func startLivePreview() {
        if thetaTask == nil {
            updateActivityIndicator("Getting api version from theta...")

            let thetaGetStateTask: ThetaGetStateTask = ThetaGetStateTask()

            thetaGetStateTask.delegate = self

            thetaGetStateTask.start()

            thetaTask = thetaGetStateTask
        }
    }

    func updateActivityIndicator(_ message: String) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.statusLabel.text = message
        }
    }

    func dismissActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.statusLabel.text = nil
        }
    }

    func thetaErrorHandler(_ errorMessage: String) {
        dismissActivityIndicator()

        alert(errorMessage)
    }
    
    @objc func sceneViewerPanGestureHandler(_ sender: UIPanGestureRecognizer) {
        camera.rotateByPanGesture(translation: sender.translation(in: sender.view), isGestureEnded: sender.state == .ended)
    }

    private class Camera {
        var node: SCNNode = SCNNode()

        var angleXZ: Float = 0.0
        var angleY: Float = 0.0

        init() {
            node.camera = SCNCamera()
            node.position = SCNVector3Zero
        }

        func rotateByPanGesture(translation: CGPoint, isGestureEnded: Bool) {
            var newAngleXZ: Float = angleXZ + Float(translation.y) * Float.pi / 180.0
            let newAngleY: Float = angleY + Float(translation.x) * Float.pi / 180.0

            if newAngleXZ > Float.pi / 2 {
                newAngleXZ = Float.pi / 2
            }

            if newAngleXZ < -1 * Float.pi / 2 {
                newAngleXZ = -1 * Float.pi / 2
            }

            node.eulerAngles.x = newAngleXZ
            node.eulerAngles.y = newAngleY

            if isGestureEnded {
                angleXZ = newAngleXZ
                angleY = newAngleY
            }
        }
    }

    private class Sphere {
        var node: SCNNode = SCNNode()

        init() {
            let geometry: SCNSphere = SCNSphere(radius: 20)
            let material: SCNMaterial = SCNMaterial()

            material.isDoubleSided = true
            material.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(-1, 1, 1), 1, 0, 0)
            material.diffuse.contents = UIColor.black

            geometry.firstMaterial = material

            node.geometry = geometry
        }
        
        func setTexture(_ image: UIImage) {
            node.geometry?.materials.first?.diffuse.contents = image
        }
    }
}

extension MainViewController: ThetaGetStateTaskDelegate {
    func thetaGetStateTask(responseData: ThetaGetStateTask.ResponseData) {
        thetaTask = nil

        dump("Client Version: \(responseData.apiVersion)")

        if responseData.apiVersion == 1 {
            updateActivityIndicator("Getting session id from theta...")

            let thetaStartSessionTask: ThetaStartSessionTask = ThetaStartSessionTask()

            thetaStartSessionTask.delegate = self

            thetaStartSessionTask.start()

            thetaTask = thetaStartSessionTask
        } else if responseData.apiVersion == 2 {
            updateActivityIndicator("Updating options for theta...")

            let thetaSetOptionsTask: ThetaSetOptionsTask = ThetaSetOptionsTask()

            thetaSetOptionsTask.delegate = self
            thetaSetOptionsTask.data(key: "parameters", value: [
                "options": [
                    "captureMode": "image",
                ],
            ])

            thetaSetOptionsTask.start()

            thetaTask = thetaSetOptionsTask
        }
    }

    func thetaGetStateTask(errorMessage: String) {
        thetaTask = nil

        thetaErrorHandler(errorMessage)
    }
}

extension MainViewController: ThetaStartSessionTaskDelegate {
    func thetaStartSessionTask(responseData: ThetaStartSessionTask.ResponseData) {
        thetaTask = nil

        updateActivityIndicator("Updating options for theta...")

        let thetaSetOptionsTask: ThetaSetOptionsTask = ThetaSetOptionsTask()

        thetaSetOptionsTask.delegate = self
        thetaSetOptionsTask.data(key: "parameters", value: [
            "sessionId": responseData.sessionId,
            "options": [
                "clientVersion": 2,
            ],
        ])

        thetaSetOptionsTask.start()

        thetaTask = thetaSetOptionsTask
    }
    
    func thetaStartSessionTask(errorMessage: String) {
        thetaTask = nil

        thetaErrorHandler(errorMessage)
    }
}

extension MainViewController: ThetaSetOptionsTaskDelegate {
    func thetaSetOptionsTask(responseData: ThetaSetOptionsTask.ResponseData) {
        thetaTask = nil

        updateActivityIndicator("Getting live preview from theta...")

        let thetaGetLivePreviewTask: ThetaGetLivePreviewTask = ThetaGetLivePreviewTask()

        thetaGetLivePreviewTask.delegate = self

        thetaGetLivePreviewTask.start()

        thetaTask = thetaGetLivePreviewTask
    }
    
    func thetaSetOptionsTask(errorMessage: String) {
        thetaTask = nil

        thetaErrorHandler(errorMessage)
    }
}

extension MainViewController: ThetaGetLivePreviewTaskDelegate {
    func thetaGetLivePreviewTask(responseData: ThetaGetLivePreviewTask.ResponseData) {
        thetaTask = nil

        sphreImage = responseData.image

        sphere.setTexture(sphreImage!)
    }
    
    func thetaGetLivePreviewTask(errorMessage: String) {
        thetaTask = nil

        thetaErrorHandler(errorMessage)
    }
}
```
