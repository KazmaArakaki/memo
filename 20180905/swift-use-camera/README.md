``` swift
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imageView: UIImageView?
    var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = view.viewWithTag(1) as? UIImageView
        button = view.viewWithTag(2) as? UIButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        button?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cameraAction)))
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView?.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cameraAction() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let cameraController = UIImagePickerController()
            cameraController.sourceType = .camera
            cameraController.delegate = self
            self.present(cameraController, animated: true, completion: nil)
        }
    }
}
```
