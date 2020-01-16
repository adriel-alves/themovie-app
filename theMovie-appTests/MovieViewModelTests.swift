import Quick
import Nimble
import CoreData

@testable import theMovie_app

class MovieViewModelTests: QuickSpec {
    
    override func spec() {
        var sut: MovieViewModel!
        var movie: Movie!
        var favoriteMovieManagerMock: FavoriteMovieManagerMock!
        
        describe("Given a movie") {
            
            beforeEach {
                movie = self.buildMovie()
                sut = MovieViewModel(movie)
                favoriteMovieManagerMock = FavoriteMovieManagerMock()
            }
            
            it("returns the correct value") {
                expect(sut.id).to(equal(123))
            }
            it("returns the correct name") {
                expect(sut.title).to(equal("Captain Marvel"))
            }
            
            it("build poster path url") {
                expect(sut.posterPath).to(equal(URL(string: "https://image.tmdb.org/t/p/original/image")))
            }
            
            it("should add a favorite") {
                let movieVM = MovieViewModel(self.buildMovie())
                sut.addOrRemoveFavoriteMovie(favoriteMovie: movieVM)
                let result = favoriteMovieManagerMock.fetch()
                expect(result?[0].id).to(equal(movieVM.id))
            }
        }
    }
    
    private func buildMovie() -> Movie! {
        let movie = Movie(id: 123,
                          title: "Captain Marvel",
                          genreIds: [Int](),
                          overview: "Voa e solta raio",
                          releaseDate: "0000",
                          posterPath: "/image")
        return movie
    }
}


