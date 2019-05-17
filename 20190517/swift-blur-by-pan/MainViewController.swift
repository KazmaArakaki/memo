import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!

    private var maskLayer: CAShapeLayer = CAShapeLayer()
    private var panGestureTrackHistory: [UIBezierPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        visualEffectView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(visualEffectViewPanGestureHandler(_:))))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let maskView: UIView = UIView(frame: visualEffectView.bounds)

        maskView.layer.addSublayer(maskLayer)

        visualEffectView.mask = maskView
    }

    @IBAction func navbarRightButtonSentActionHandler(_ sender: UIBarButtonItem) {
    }

    @objc func visualEffectViewPanGestureHandler(_ sender: UIPanGestureRecognizer) {
        let location: CGPoint = sender.location(in: visualEffectView)

        if sender.state == .began {
            let newPanGestureTrackPath: UIBezierPath = UIBezierPath()

            newPanGestureTrackPath.move(to: location)

            panGestureTrackHistory.append(newPanGestureTrackPath)
        }

        if let lastPanGestureTrackPath: UIBezierPath = panGestureTrackHistory.last {
            lastPanGestureTrackPath.addLine(to: location)
        }

        update()
    }

    private func update() {
        let path: UIBezierPath = UIBezierPath()

        for panGestureTrackPath: UIBezierPath in panGestureTrackHistory {
            path.append(panGestureTrackPath)
        }

        maskLayer.fillColor = nil
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.lineWidth = 20
        maskLayer.lineCap = .round
        maskLayer.path = path.cgPath
    }
}
