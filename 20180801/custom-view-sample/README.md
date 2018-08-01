**ViewController.swift**

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView = CustomView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        view.addSubview(customView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
```

**Components/CustomView/CustomView.xib**

just added simple label

**Components/CustomView/CustomView.swift**

```swift
import UIKit

class CustomView: UIView {
    @IBOutlet weak var customView: UIView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        loadNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNib()
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        customView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        addSubview(customView)
    }
}
```
