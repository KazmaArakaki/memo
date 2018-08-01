**ViewController.swift**

```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.magenta
        
        containerView.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        let image1 = UIImage(named: "SampleImage1")!
        let imageView1 = UIImageView(image: image1)
        imageView1.bounds = CGRect(x: 0, y: 0, width: image1.size.width, height: image1.size.height)
        
        scrollView.addSubview(imageView1)
        imageView1.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView1.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageView1.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        imageView1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        scrollView.contentSize = CGSize(width: imageView1.bounds.width, height: imageView1.bounds.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
```
