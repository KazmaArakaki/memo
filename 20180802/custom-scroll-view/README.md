**Component/CustomScrollView/CustomScrollView.swift**

```swift
import UIKit

class CustomScrollView: UIView {
    private let scrollView: UIScrollView = UIScrollView(frame: CGRect.zero)
    private var contentWidth: CGFloat = CGFloat(0)
    private var originalFrameWidth: CGFloat = CGFloat(0)
    private var itemWidth: CGFloat = CGFloat(0)
    private var itemHeight: CGFloat = CGFloat(0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self._init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self._init()
    }
    
    private func _init() {
        self.originalFrameWidth = self.bounds.size.width
        self.itemWidth = self.frame.height * 3 / 4
        self.itemHeight = self.frame.height
        
        self.addSubview(self.scrollView)
        self.scrollView.frame = CGRect(x: (self.bounds.width - self.itemWidth) / 2, y: 0, width: self.itemWidth, height: self.itemHeight)
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.clipsToBounds = false
        
        let item1 = self.createScrollItem()
        self.setScrollItem(item1)
        
        let item2 = self.createScrollItem()
        self.setScrollItem(item2)
        
        let item3 = self.createScrollItem()
        self.setScrollItem(item3)
        
        let item4 = self.createScrollItem()
        self.setScrollItem(item4)
        
        let item5 = self.createScrollItem()
        self.setScrollItem(item5)
    }
    
    private func setScrollItem(_ item: UIView) {
        item.frame = CGRect(x: CGFloat(self.contentWidth), y: CGFloat(0), width: item.bounds.width, height: item.bounds.height)
        
        self.contentWidth = item.frame.maxX
        self.scrollView.contentSize = CGSize(width: self.contentWidth, height: self.bounds.height)
        
        self.scrollView.addSubview(item)
    }
    
    private func createScrollItem() -> UIView {
        return CustomScrollItemView(frame: CGRect(x: 0, y: 0, width: self.itemWidth, height: self.itemHeight))
    }
}
```

**Component/CustomScrollItemView/CustomScrollItemView.swift**

```swift
import UIKit

class CustomScrollItemView: UIView {
    override func draw(_ rect: CGRect) {
        let bgRect = UIBezierPath(rect: rect)
        UIColor.white.set()
        bgRect.fill()
        
        UIColor.black.set()
        bgRect.stroke()
    }
}
```

**Main.storyboard**
