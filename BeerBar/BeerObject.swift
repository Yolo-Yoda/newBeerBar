import Foundation
import RealmSwift

class BeerObject: Object {
    @Persisted var name = ""
    @Persisted var price = 0.0
    @Persisted var sendingCountry = ""
    @Persisted var remainderVolume = 0.0
}
