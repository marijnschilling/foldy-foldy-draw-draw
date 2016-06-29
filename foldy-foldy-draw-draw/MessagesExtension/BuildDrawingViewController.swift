import UIKit

protocol BuildDrawingViewControllerDelegate: class {
    func buildDrawingViewController(_: BuildDrawingViewController, didFinishDrawing: NWADrawing, forState: DrawingState)
}

enum DrawingState {
    case none
    case head
    case torso
    case legs
    case feet
}

class BuildDrawingViewController: UIViewController {
    
    static let storyboardIdentifier = "BuildDrawingViewController"

    var drawing: Drawing?
    
    let state = DrawingState.none

    weak var delegate: BuildDrawingViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var drawingView: NWADrawingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "Draw a head!"
        self.instructionLabel.text = "Extend the neck under the line"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    @IBAction func foldButtonPressed(_ sender: AnyObject) {
        self.delegate?.buildDrawingViewController(self, didFinishDrawing: self.drawingView.drawing, forState: self.state)
    }
}
