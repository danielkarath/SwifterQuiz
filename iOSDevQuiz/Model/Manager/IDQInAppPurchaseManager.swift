//
//  IDQInAppPurchaseManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/20/23.
//

import Foundation
import StoreKit
import Combine

final class IDQInAppPurchaseManager: NSObject, ObservableObject {
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    enum IDQProduct: String, CaseIterable {
        case IDQ_BuyMeCoffee
        
    }
    
    enum PurchaseState {
        case none
        case purchasing
        case purchased
        case failed
        case restored
    }
        
    //MARK: - Public
    static let shared = IDQInAppPurchaseManager()
    
    public var products: [SKProduct] = []
    @Published public var purchaseState: PurchaseState = .none
    @Published public var purchaseError: SKError?
    
    public func fetchProducts() {
        //DispatchQueue.global(qos: .background).async {
            let request = SKProductsRequest(productIdentifiers: Set(IDQProduct.allCases.compactMap({ $0.rawValue })))
            request.delegate = self
            request.start()
        //}
    }
    
    public func purchase(_ product: IDQProduct) {
        guard SKPaymentQueue.canMakePayments() else { return }
        guard let storeKitProduct = products.first(where: { $0.productIdentifier == product.rawValue }) else {
            return
        }
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(paymentRequest)
    }
}

extension IDQInAppPurchaseManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
    }
}

extension IDQInAppPurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchasing:
                if let product = IDQProduct(rawValue: $0.payment.productIdentifier) {
                    purchaseState = .purchasing
                    print("Atempting to purchase the product: \(product.rawValue)")
                }
            case .purchased:
                if let product = IDQProduct(rawValue: $0.payment.productIdentifier) {
                    purchaseState = .purchased
                    print("Successful transaction for the product: \(product.rawValue)")
                }
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                purchaseState = .failed
                if let error = $0.error as? SKError {
                    switch error.code {
                    case .paymentCancelled:
                        print("The user has cancelled the purchase")
                    case .paymentInvalid:
                        print("The purchase identifier is invalid")
                    case .paymentNotAllowed:
                        print("The user is not allowed to make a payment")
                    case .clientInvalid:
                        print("The client is not allowed to make the purchase")
                    case .storeProductNotAvailable:
                        print("The product is not available in the current storefront")
                    default:
                        print("Error: \(error.localizedDescription)")
                    }
                }
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                purchaseState = .restored
                SKPaymentQueue.default().finishTransaction($0)
            case .deferred:
                purchaseState = .none
                break
            @unknown default:
                purchaseState = .none
                break
            }
        }
    }
}
