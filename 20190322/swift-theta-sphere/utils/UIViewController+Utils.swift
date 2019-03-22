``` swift
import UIKit

extension UIViewController {
    func alert(_ message: String) {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)

            alert.addAction(defaultAction)

            self.present(alert, animated: true, completion: nil)
        }
    }
}
```
