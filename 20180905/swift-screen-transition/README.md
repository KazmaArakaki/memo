``` swift
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.present(LoginViewController(), animated: true, completion: nil)
    }
}
```

**LoginViewController.swift**

``` swift
import UIKit

class LoginViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("login view")
    }
}
```
