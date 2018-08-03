**ViewController.swift**

```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loadingAnimationView: LoadingAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingAnimationView.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
```

**Component/LoadingAnimationView/LoadingAnimationView.swift**

```swift
import UIKit

class LoadingAnimationView: UIView {
    let containerViewWidth = 120
    let containerViewHeight = 120
    let containerView = UIView(frame: CGRect.zero)
    let animationIconViewsCount = 5
    let animationIconViewsMarginX = 8
    var animationIconViews = Array<UIView>()
    var animationIconViewConstraints = Dictionary<Int, Dictionary<String, NSLayoutConstraint>>()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self._init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self._init()
    }
    
    private func _init() {
        self._addViewMembersAsSubviews()
        self._addConstraintsToViewMembers()
        self._drawViewMembers()
    }
    
    public func startAnimation() {
        for i in 1...self.animationIconViewsCount {
            UIView.animate(withDuration: 1.0, delay: Double(i % 2), options: [.autoreverse, .repeat], animations: {
                self.animationIconViewConstraints[i - 1]!["height"]?.constant *= 2
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func _drawViewMembers() {
        for i in 1...self.animationIconViewsCount {
            let animationIconView = self.animationIconViews[i - 1]
            animationIconView.backgroundColor = UIColor.cyan
        }
    }
    
    private func _addConstraintsToViewMembers() {
        let containerViewWidth = CGFloat(self.containerViewWidth)
        let containerViewHeight = CGFloat(self.containerViewHeight)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.containerView.widthAnchor.constraint(equalToConstant: containerViewWidth).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: containerViewHeight).isActive = true
        
        let iconViewMarginX = CGFloat(self.animationIconViewsMarginX)
        let iconViewsCount = CGFloat(self.animationIconViewsCount)
        for i in 1...self.animationIconViewsCount {
            let animationIconView = self.animationIconViews[i - 1]
            let animationIconViewSize = (containerViewWidth / iconViewsCount) - iconViewMarginX;
            
            animationIconView.translatesAutoresizingMaskIntoConstraints = false
            
            let leadingConstraint = animationIconView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: ((containerViewWidth / iconViewsCount) * CGFloat(i - 1)) + iconViewMarginX / 2)
            leadingConstraint.isActive = true
            
            let centerYConstraint = animationIconView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor)
            centerYConstraint.isActive = true
            
            let widthConstraint = animationIconView.widthAnchor.constraint(equalToConstant: animationIconViewSize)
            widthConstraint.isActive = true
            
            let heightConstraint = animationIconView.heightAnchor.constraint(equalToConstant: animationIconViewSize)
            heightConstraint.isActive = true
            
            self.animationIconViewConstraints[i - 1] = [
                "leading": leadingConstraint,
                "centerY": centerYConstraint,
                "width": widthConstraint,
                "height": heightConstraint,
            ]
        }
    }
    
    private func _addViewMembersAsSubviews() {
        self.addSubview(self.containerView)
        
        for _ in 1...self.animationIconViewsCount {
            let animationIconView = UIView(frame: CGRect.zero)
            self.animationIconViews.append(animationIconView)
            self.containerView.addSubview(animationIconView)
        }
    }
}
```
