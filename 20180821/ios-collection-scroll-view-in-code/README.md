``` swift
import UIKit

class CollectionScrollView: UIView {
    var itemWidth: CGFloat = 0
    var itemHeight: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self._init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self._init()
    }
    
    private func _init() {
        self.itemWidth = self.bounds.size.height * 2 / 3
        self.itemHeight = self.bounds.size.height
        
        let collectionViewLayout = OverlapCollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: self.itemWidth, height: self.itemHeight)
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        collectionView.isPagingEnabled = true
        collectionView.clipsToBounds = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(collectionView)
        self.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: (self.bounds.size.width - self.itemWidth) / 2).isActive = true
        self.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: collectionView.leftAnchor, constant: -1 * (self.bounds.size.width - self.itemWidth) / 2).isActive = true
    }
    
    class OverlapCollectionViewFlowLayout: UICollectionViewFlowLayout {
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let attributes = super.layoutAttributesForElements(in: rect)
            
            for attribute in attributes! {
                attribute.bounds.size.width += 8
            }
            
            return attributes
        }
    }
}

extension CollectionScrollView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
}
```
