//
//  OpenAIRouter.swift
//  StorySpace
//
//  Created by Ahmet Tarık Demirci on 12.08.2024.
//

import Foundation
import Alamofire

/// `OpenAIRouter` OpenAI servisleriyle etkileşime geçmek için farklı API uç noktalarını tanımlayan bir enum'dur.
/// Şu anda mesaj gönderme ve DALL-E kullanarak görüntü oluşturma işlemlerini desteklemektedir.
enum OpenAIRouter {
    
    /// OpenAI sohbet modeline bir mesaj gönderir.
    /// - Parametreler:
    ///   - model: Tamamlanma için kullanılacak model (örneğin, "gpt-4").
    ///   - message: Modele gönderilecek kullanıcı mesajı.
    case sendMessage(model: String, message: String)
    
    /// DALL-E modelini kullanarak bir istek ve belirli bir sanat tarzına göre görüntü oluşturur.
    /// - Parametreler:
    ///   - prompt: Oluşturulacak görüntüyü tanımlayan istek.
    ///   - artStyle: Oluşturulacak görüntü için uygulanacak sanat tarzı.
    case generateImage(prompt: String, artStyle: String)
}

extension OpenAIRouter: URLRequestConfigurable {
    
    /// OpenAI API'si için temel URL.
    var baseURL: URL? {
        return URL(string: ApiConstants.baseURLString)
    }
    
    /// Router vakasına bağlı olarak API uç noktası için belirli yol.
    var path: String {
        switch self {
        case .sendMessage:
            return "/chat/completions"
        case .generateImage:
            return "/images/generations"
        }
    }

    /// API isteği için kullanılacak HTTP metodu. Şu anda tüm uç noktalar POST metodunu kullanmaktadır.
    var method: HTTPMethod {
        return .post
    }
    
    /// Router vakasına bağlı olarak isteğe dahil edilecek gövde parametreleri.
    /// - Returns: İlgili API isteği için gerekli olan parametreleri içeren bir `Parameters` sözlüğü.
    ///
    /// `sendMessage` durumu için gönderilen parametreler:
    /// - `model`: Kullanılacak OpenAI modeli (örneğin, "gpt-4").
    /// - `messages`: Kullanıcının mesajını içeren bir dizi. Bu dizi, role (örn. "user") ve content (mesaj içeriği) anahtarlarıyla yapılandırılmıştır.
    ///
    /// `generateImage` durumu için gönderilen parametreler:
    /// - `model`: Kullanılacak DALL-E modelinin adı (örneğin, "dall-e-3").
    /// - `prompt`: Oluşturulacak görüntüyü tanımlayan metin isteği.
    /// - `style`: Görüntünün oluşturulacağı sanat tarzı.
    /// - `size`: Görüntünün boyutu (örneğin, "1024x1024").
    /// - `quality`: Görüntü kalitesi (örneğin, "standard").
    /// - `n`: Üretilmesi istenen görüntü sayısı (bu durumda 1 olarak ayarlanmıştır).
    var bodyParameters: Parameters? {
        switch self {
        case .sendMessage(let model, let message):
            return [
                "model": model,
                "messages": [
                    ["role": "user", "content": message]
                ]
            ]
        case .generateImage(let prompt, let artStyle):
            return [
                "model": "dall-e-3",
                "prompt": "Bu hikayeye dayanarak ayrıntılı bir görüntü oluşturun: \(prompt), yalnızca görsel unsurlara odaklanarak, metin içermeden. Stil: \(artStyle)",
                "size": "1024x1024",
                "quality": "standard",
                "n": 1
            ]
        }
    }
    
    /// API isteği için URL parametreleri. Şu anda URL parametresi bulunmamaktadır.
    var urlParameters: Parameters? {
        return nil
    }
    
    /// Gövde parametreleri için kodlama türü. JSON kodlaması kullanılmaktadır.
    var bodyParameterEncoding: BodyParameterEncoding {
        return .jsonEncoding
    }
    
    /// API isteğine dahil edilecek HTTP başlıkları.
    /// - Not: Yetkilendirme başlığı bir OpenAI API token olan `Bearer` token içerir ve güvenli bir şekilde yönetilmelidir.
    var headers: HTTPHeaders? {
        return [
           
            "Authorization": "Bearer Kendi Tokenininizi Girin",
            "Content-Type": "application/json"
        ]
    }
    
    /// `OpenAIRouter` vakasını bir `URLRequest` nesnesine dönüştürür.
    /// - Throws: URL oluşturma başarısız olursa hata fırlatır.
    /// - Returns: Yapılandırılmış bir `URLRequest` nesnesi.
    func asURLRequest() throws -> URLRequest {
        guard let url = baseURL?.appendingPathComponent(path) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        try configure(urlRequest: &urlRequest)
        return urlRequest
    }
    
}
