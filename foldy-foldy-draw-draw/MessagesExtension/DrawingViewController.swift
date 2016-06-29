import UIKit

protocol DrawingViewControllerDelegate: class {
    func drawingViewControllerDidSelectAdd(_ controller: DrawingViewController)
}

class DrawingViewController: UIViewController {

    static let storyboardIdentifier = "DrawingViewController"

    weak var delegate: DrawingViewControllerDelegate?
    
    @IBAction func newDrawingButtonPressed(_ sender: UIButton) {
        
       self.delegate?.drawingViewControllerDidSelectAdd(self)
    }
}
