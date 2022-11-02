struct Model: Decodable {

    var results: [Result]?

    struct Result: Decodable {

        let title: String?
    }
}
