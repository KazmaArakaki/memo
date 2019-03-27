import UIKit

extension UIView {
    func toUIImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)

        defer {
            UIGraphicsEndImageContext()
        }

        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            return nil
        }

        layer.render(in: context)

        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        return image
    }
}
