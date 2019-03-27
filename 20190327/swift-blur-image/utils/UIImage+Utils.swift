import UIKit

extension UIImage {
    func grayScale() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        guard
            let context = CGContext(
                data: nil,
                width: Int(size.width),
                height: Int(size.height),
                bitsPerComponent: 8,
                bytesPerRow: 0,
                space: CGColorSpaceCreateDeviceGray(),
                bitmapInfo: CGImageAlphaInfo.none.rawValue
            ),
            let cgImage = cgImage
        else {
            return nil
        }

        context.draw(cgImage, in: rect)

        guard let image = context.makeImage() else {
            return nil
        }

        return UIImage(cgImage: image)
    }

    func blur(_ radius: Int) -> UIImage? {
        let ciContext = CIContext(options: nil)

        guard let cgImage = self.cgImage else {
            return nil
        }

        let ciImage = CIImage(cgImage: cgImage)

        guard let ciFilter = CIFilter(name: "CIGaussianBlur") else {
            return nil
        }

        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(radius, forKey: "inputRadius")

        guard let blurredCiImage: CIImage = ciFilter.value(forKey: kCIOutputImageKey) as? CIImage else {
            return nil
        }

        guard let blurredCgImage = ciContext.createCGImage(blurredCiImage, from: ciImage.extent) else {
            return nil
        }

        return UIImage(cgImage: blurredCgImage)
    }

    func mask(with maskImage: UIImage) -> UIImage? {
        guard let maskCgImage: CGImage = maskImage.cgImage else {
            return nil
        }

        guard let maskProvider: CGDataProvider = maskCgImage.dataProvider else {
            return nil
        }

        guard
            let mask: CGImage = CGImage(
                maskWidth: maskCgImage.width,
                height: maskCgImage.height,
                bitsPerComponent: maskCgImage.bitsPerComponent,
                bitsPerPixel: maskCgImage.bitsPerPixel,
                bytesPerRow: maskCgImage.bytesPerRow,
                provider: maskProvider,
                decode: nil,
                shouldInterpolate: false
            )
            else {
                return nil
        }

        guard
            let cgImage: CGImage = self.cgImage,
            let maskedCgImage: CGImage = cgImage.masking(mask)
        else {
                return nil
        }

        return UIImage(cgImage: maskedCgImage)
    }

    func composite(with image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        defer {
            UIGraphicsEndImageContext()
        }

        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let rect: CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)

        image.draw(in: rect)
        
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        return image
    }
}
