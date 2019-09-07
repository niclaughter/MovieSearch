//
//  MovieSearchTests.swift
//  MovieSearchTests
//  Copyright © 2019 Nic Laughter. All rights reserved.
//

import XCTest
@testable import MovieSearch

class MovieSearchTests: XCTestCase {
    
    func testMovieConstruction() {
        let responseData = responseString.data(using: .utf8)
        
        guard let data = responseData,
            let response = try? JSONSerialization.jsonObject(with: data) as? JSONDictionary,
            let movieDictionaries = response["results"] as? MovieDataDictionaries,
            let movie = movieDictionaries.compactMap({ Movie($0)}).first else { return XCTFail() }
        XCTAssertEqual(movie.title, "Hot Fuzz")
    }
    
    func testCount() {
        let responseData = responseString.data(using: .utf8)
        
        guard let data = responseData,
            let response = try? JSONSerialization.jsonObject(with: data) as? JSONDictionary,
            let movieDictionaries = response["results"] as? MovieDataDictionaries else { return XCTFail() }
        let movies = movieDictionaries.compactMap({ Movie($0)})
        XCTAssertEqual(movies.count, 1)
    }
    
    let responseString = """
{
    "page": 1,
    "total_results": 1378,
    "total_pages": 69,
    "results": [
        {
            "vote_count": 4012,
            "id": 4638,
            "video": false,
            "vote_average": 7.5,
            "title": "Hot Fuzz",
            "popularity": 13.924,
            "poster_path": "/zqYnY7Y60oIlQOvx2tdzMSk6yYe.jpg",
            "original_language": "en",
            "original_title": "Hot Fuzz",
            "genre_ids": [
                80,
                28,
                35
            ],
            "backdrop_path": "/7aHa9or0TdQiwddj2PLV67EVOxO.jpg",
            "adult": false,
            "overview": "As a former London constable, Nicholas Angel finds it difficult to adapt to his new assignment in the sleepy British village of Sandford. Not only does he miss the excitement of the big city, but he also has a well-meaning oaf for a partner. However, when a series of grisly accidents rocks Sandford, Angel smells something rotten in the idyllic village.",
            "release_date": "2007-02-14"
        },
        {
            "vote_count": 466,
            "id": 10074,
            "video": false,
            "vote_average": 6.3,
            "tilte": "Hot Rod",
            "popularity": 9.52,
            "poster_path": "/6LDKcAFFNJ3ra1a5LgPSiAbyJHC.jpg",
            "original_language": "en",
            "original_title": "Hot Rod",
            "genre_ids": [
                28,
                35
            ],
            "backdrop_path": "/hFYWZ7JdU0fTPh2vnqUPd9avRh8.jpg",
            "adult": false,
            "overview": "For Rod Kimball, performing stunts is a way of life, even though he is rather accident-prone. Poor Rod cannot even get any respect from his stepfather, Frank, who beats him up in weekly sparring matches. When Frank falls ill, Rod devises his most outrageous stunt yet to raise money for Frank's operation -- and then Rod will kick Frank's butt.",
            "release_date": "2007-08-03"
        },
    ]
}
"""
}
