import UIKit

class BuildDrawingViewController: UIViewController {
    
    static let storyboardIdentifier = "BuildDrawingViewController"

    var drawing: Drawing?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var drawingView: NWADrawingView!
    @IBAction func foldButtonPressed(_ sender: AnyObject) {
    }
}
