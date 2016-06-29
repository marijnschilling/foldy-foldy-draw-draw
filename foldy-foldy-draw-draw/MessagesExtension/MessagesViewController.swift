import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        self.presentViewController(for: conversation, with: presentationStyle)
    }
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        // Determine the controller to present.
        let controller: UIViewController
        
        if presentationStyle == .compact {
            controller = instantiateDrawingsController()
        }
        else {
            
            let drawing = Drawing(message: conversation.selectedMessage) ?? Drawing()
            
            if drawing.isComplete {
                controller = instantiateCompletedDrawingController(with: drawing)
            }
            else {
                controller = instantiateBuildDrawingViewController(with: drawing)
            }
        }
    }

    private func instantiateDrawingsController() -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: DrawingViewController.storyboardIdentifier) as? DrawingViewController else { fatalError("Unable to instantiate a DrawingViewController from the storyboard") }

        return controller
    }

    private func instantiateCompletedDrawingController(with drawing: Drawing) -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: CompletedDrawingViewController.storyboardIdentifier) as? CompletedDrawingViewController else { fatalError("Unable to instantiate a CompletedDrawingController from the storyboard") }

        controller.drawing = drawing

        return controller
    }

    private func instantiateBuildDrawingViewController(with drawing: Drawing) -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: BuildDrawingViewController.storyboardIdentifier) as? BuildDrawingViewController else { fatalError("Unable to instantiate a BuildDrawingViewController from the storyboard") }

        controller.drawing = drawing

        return controller
    }
}
