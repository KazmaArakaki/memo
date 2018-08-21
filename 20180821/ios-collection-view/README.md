``` swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let overlapLayout = OverlapCollectionViewFlowLayout()
        overlapLayout.itemSize = CGSize(width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height)
        overlapLayout.scrollDirection = .horizontal
        overlapLayout.minimumInteritemSpacing = 0
        overlapLayout.minimumLineSpacing = 0
        
        self.collectionView.collectionViewLayout = overlapLayout
        self.collectionView.isPagingEnabled = true
        self.collectionView.clipsToBounds = false
        self.collectionView.dataSource = self
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

extension ViewController: UICollectionViewDataSource {
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
