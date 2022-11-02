import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxAlamofire

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
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let this = self else { return }
                this.networkCall()
            }).disposed(by: disposeBag)
    }
}

extension ViewController {

    private func networkCall() {
        let encoding = URLEncoding()

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        RxAlamofire.data(
            .get,
            "https://api.themoviedb.org/3/movie/now_playing",
            parameters: ["api_key" : "f920accbb779fcb3ab3bbec9a8b40bd0"],
            encoding: encoding
        )
        .throttle(.seconds(1), scheduler: MainScheduler.instance)
        .subscribe(onNext: { [weak self] response in
            guard let _ = self else { return }

            do {
                let model = try decoder.decode(Model.self, from: response)
                let results = model.results
                let titles = results?.compactMap { data in data.title } ?? []
                dump(titles)
            } catch {
                print(error)
            }
        }).disposed(by: disposeBag)
    }
}
