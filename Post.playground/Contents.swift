import UIKit
import Foundation

class Post {
    var author: String
    var content: String
    var likes: Int
    
    //Initialization to the Post class
    init(author: String, content: String, likes: Int) {
        self.author = author
        self.content = content
        self.likes = likes
    }
    
    //Display Method
    func display() -> String {
        "\(author)'s \(content) Post got \(likes) likes!!!"
    }
}

//Creating Two differeent Posts
let post1 = Post(author: "Susmitha", content: "Happy Birthday", likes: 115)
let post2 = Post(author: "Siri", content: "Trip to Mangalore", likes: 123)

//Calling display method on each Post Object.
print(post1.display())
print(post2.display())
