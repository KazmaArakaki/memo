import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imageCanvasComponent: ImageCanvasView!

    override func viewDidLoad() {
        super.viewDidLoad()

        container.clipsToBounds = true
        container.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(containerPinchGestureHandler(_:))))
    }


    @objc private func containerPinchGestureHandler(_ sender: UIPinchGestureRecognizer) {
        imageCanvasComponent.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
}
