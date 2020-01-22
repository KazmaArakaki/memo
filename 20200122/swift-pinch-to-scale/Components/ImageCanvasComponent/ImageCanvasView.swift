import UIKit
import AVFoundation

class ImageCanvasView: UIView {
    @IBOutlet weak var preview: UIImageView!

    private var containerView: UIView?
    private var gestureLayer: GestureLayer = GestureLayer(frame: .zero)

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        let nib: UINib = UINib(nibName: "ImageCanvasView", bundle: nil)

        if let containerView: UIView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            containerView.frame = bounds
            containerView.addSubview(gestureLayer)

            addSubview(containerView)

            self.containerView = containerView
        }

        gestureLayer.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(gestureLayerPanGestureHandler(_:))))
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        adjustLayout()
    }

    @objc private func gestureLayerPanGestureHandler(_ sender: UIPanGestureRecognizer) {
        let location: CGPoint = sender.location(in: gestureLayer)

        switch sender.state {
        case .began:
            gestureLayer.path.move(to: location)
        default:
            break
        }

        gestureLayer.path.addLine(to: location)

        gestureLayer.setNeedsDisplay()
    }

    private func adjustLayout() {
        if let image: UIImage = preview.image, let containerView: UIView = containerView {
            gestureLayer.frame = AVMakeRect(aspectRatio: image.size, insideRect: containerView.bounds)
        }
    }

    private class GestureLayer: UIView {
        var path: UIBezierPath = UIBezierPath()

        override func draw(_ rect: CGRect) {
            backgroundColor = UIColor.clear

            UIColor.white.setStroke()

            path.lineWidth = 5.0
            path.lineCapStyle = .round
            path.stroke()
        }
    }
}
