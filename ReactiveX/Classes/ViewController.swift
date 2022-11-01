import UIKit
import RxSwift
import RxCocoa

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

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)

        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        button.rx
            .controlEvent(.touchUpInside)
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let _ = self else { return }

                // TODO: Invoke network call
            }).disposed(by: disposeBag)
    }
}
