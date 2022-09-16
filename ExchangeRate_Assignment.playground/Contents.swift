import UIKit

/*질문
 -. 왜 변수를 새로만들어서 처리해야하는지? 재귀함수 오류?
 
 */
struct ExchangeRate {
    var currencyRate: Double {
        willSet {
            print("currencyRate willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
        }
        didSet {
            print("currencyRate didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
    }
    
    var USD: Double {
        willSet {
            print("USD willSet - 환전금액 : USD: \(newValue)달러로 환전될 예정")
        }
        didSet {
            print("USD didSet - KRW: \(KRW)원 -> \(KRW / currencyRate)달러로 환전되었음")
        }
        
    }
    
    var _KRW = 0.0
    var KRW: Double {
        get {
            _KRW
        }
        
        set {
            _KRW = newValue
            USD = KRW / currencyRate
        }
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
