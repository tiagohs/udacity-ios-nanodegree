
import Foundation

class Photo {
    var id: String!
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Bool?
    var title: String?
    var isPublic: Bool?
    var isFriend: Bool?
    var isFamily: Bool?
    var url: String?
    var height: String?
    var width: String?
    
    var isFavorite: Bool = false
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.owner = json["owner"] as? String
        self.secret = json["secret"] as? String
        self.server = json["server"] as? String
        self.farm = ((json["farm"] as? Int) == 1)
        self.title = json["title"] as? String
        self.isPublic = ((json["ispublic"] as? Int) == 1)
        self.isFriend = ((json["isfriend"] as? Int) == 1)
        self.isFamily = ((json["isfamily"] as? Int) == 1)
        self.url = json["url_m"] as? String
        self.height = json["height_m"] as? String
        self.width = json["width_m"] as? String
    }
    
    // MARK: Mocks
    
    static func PhotoMock(id: String) -> Photo {
        return Photo(json: [
            "id": id,
            "title": "Title Test",
            "url_m": Constants.ImageMockURL
        ] as [String: AnyObject])!
    }
    
    static func PhotosMock() -> [Photo] {
        return [
            Photo.PhotoMock(id: "1"),
            Photo.PhotoMock(id: "2"),
            Photo.PhotoMock(id: "3"),
            Photo.PhotoMock(id: "4"),
            Photo.PhotoMock(id: "5"),
            Photo.PhotoMock(id: "6"),
            Photo.PhotoMock(id: "7"),
            Photo.PhotoMock(id: "8"),
            Photo.PhotoMock(id: "9"),
            Photo.PhotoMock(id: "10")
        ]
    }
}
