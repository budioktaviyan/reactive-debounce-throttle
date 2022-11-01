import UIKit

class ViewController: UIViewController {

    let button: UIButton = {
        let view = UIButton()

        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.contentEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.setTitle("Click", for: .normal)
        view.setTitleColor(.black, for: .normal)

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)

        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}