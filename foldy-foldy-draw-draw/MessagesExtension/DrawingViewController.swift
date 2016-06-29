import UIKit

protocol DrawingViewControllerDelegate {
    func drawingViewControllerDidSelectAdd(_ controller: IceCreamsViewController)
}

class DrawingViewController: UIViewController {

    static let storyboardIdentifier = "DrawingViewController"

    weak var delegate: DrawingViewControllerDelegate?
    
    @IBAction func newDrawingButtonPressed(_ sender: UIButton) {
        
        
    }
}
