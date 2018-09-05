``` swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func longPressAction(sender: UILongPressGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.began) {
            print("began long press")
        }
        else if (sender.state == UIGestureRecognizerState.ended) {
            print("ended long press")
        }
    }
}
```
