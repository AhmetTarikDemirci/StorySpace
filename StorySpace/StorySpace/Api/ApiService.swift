//
//  ApiService.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import Foundation
import Alamofire

/// `ApiService`, uygulamanızın API isteklerini ve yanıtlarını yöneten bir hizmet sınıfıdır.
/// Bu sınıf, Singleton olarak yapılandırılmıştır, bu sayede uygulama genelinde tek bir örnek üzerinden kullanılabilir.
final class ApiService {
    
    /// `ApiService` sınıfının tek örneği.
    static let shared = ApiService()
    
    /// Alamofire oturumu (`Session`) örneği, API isteklerini yönetmek için kullanılır.
    private let AFSession: Session
    
    /// JSON verilerini çözümlemek için kullanılan `JSONDecoder` örneği.
    private let jsonDecoder: JSONDecoder
    
    /// `ApiService` sınıfının özel başlatıcı metodu. Sadece `shared` üzerinden erişilebilir.
    /// - Not: URLSessionConfiguration yapılandırması yapılarak `waitsForConnectivity` özelliği etkinleştirilmiştir, böylece internet bağlantısı beklenir.
    private init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.waitsForConnectivity = true
        self.AFSession = Session(configuration: configuration)
        self.jsonDecoder = JSONDecoder()
    }
    
    /// Genel API isteklerini yapmak için kullanılan metod.
    /// - Parameters:
    ///   - urlReq: URL isteklerini yapılandıran bir nesne (`URLRequestConvertible`).
    ///   - type: Beklenen yanıt türü, `Decodable` protokolünü uygulayan bir tür olmalıdır.
    ///   - completion: İsteğin tamamlanması durumunda çağrılan kapanış bloğu, isteğin sonucunu (`Result<T, Error>`) ve HTTP durum kodunu içerir.
    func request<T: Decodable>(
        _ urlReq: URLRequestConvertible,
        type: T.Type,
        completion: @escaping (Result<T, Error>, Int?) -> Void) {
        
        AFSession.request(urlReq)
            .validate() // Otomatik hata kontrolü ekler
            .responseDecodable(of: T.self, decoder: jsonDecoder) { response in
                completion(response.result.mapError { $0 as Error }, response.response?.statusCode)
            }
    }
    
    /// Bir URL'den görüntü indirmek için kullanılan metod.
    /// - Parameters:
    ///   - url: İndirilecek görüntünün URL'si.
    ///   - completion: İndirmenin tamamlanması durumunda çağrılan kapanış bloğu, isteğin sonucunu (`Result<Data, Error>`) içerir.
    func downloadImage(from url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        AFSession.request(url)
            .validate() // Otomatik hata kontrolü ekler
            .responseData { response in
                completion(response.result.mapError { $0 as Error })
            }
    }
}
