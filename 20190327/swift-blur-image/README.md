``` swift
import UIKit
import AudioToolbox

class MainViewController: UIViewController {
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var gestureLayerContainer: UIView!

    private let gestureLayer: GestureLayer = GestureLayer()

    private let originalImage: UIImage = UIImage(named: "theta")!
    private var blurredOriginalImage: UIImage? {
        return originalImage.blur(10)
    }

    private var image: UIImage? = nil {
        didSet {
            if let image: UIImage = image {
                imagePreview.image = image
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        image = originalImage

        gestureLayerContainer.addSubview(gestureLayer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        gestureLayer.frame = gestureLayerContainer.bounds
        gestureLayer.setNeedsDisplay()
    }

    @IBAction func navbarSubmitButtonPressHandler(_ sender: UIBarButtonItem) {
        guard let maskImage: UIImage = gestureLayer.toUIImage()?.grayScale() else {
            return
        }

        guard let maskedImage: UIImage = originalImage.mask(with: maskImage) else {
            return
        }

        if let blurredOriginalImage: UIImage = blurredOriginalImage {
            image = blurredOriginalImage.composite(with: maskedImage)
        } else {
            image = maskedImage
        }
    }

    class GestureLayer: UIView {
        var paths: [UIBezierPath] = []
        var activePath: UIBezierPath? = nil

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)

            addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureHandler(_:))))
        }

        override func draw(_ rect: CGRect) {
            guard let context: CGContext = UIGraphicsGetCurrentContext() else {
                return
            }

            context.setFillColor(UIColor.black.cgColor)
            context.setStrokeColor(UIColor.white.cgColor)
            context.fill(rect)

            var _paths: [UIBezierPath] = [] + paths

            if let path: UIBezierPath = activePath {
                _paths += [path]
            }

            for path: UIBezierPath in _paths {
                path.lineCapStyle = .round
                path.lineWidth = 20.0

                path.stroke()
            }
        }

        @objc func longPressGestureHandler(_ sender: UILongPressGestureRecognizer) {
            let touchLocation: CGPoint = sender.location(in: self)

            guard
                touchLocation.x >= 0,
                touchLocation.y >= 0,
                touchLocation.x <= frame.width,
                touchLocation.y <= frame.height
            else {
                return
            }

            if sender.state == .began {
                if activePath == nil {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)

                    activePath = UIBezierPath()
                    activePath?.move(to: touchLocation)
                }
            } else if sender.state == .changed {
                if activePath != nil {
                    activePath?.addLine(to: touchLocation)
                }
            } else if sender.state == .ended {
                if activePath != nil {
                    paths.append(activePath!)

                    activePath = nil
                }
            }

            setNeedsDisplay()
        }
    }
}
```
