# StorySpace
# Proje Hakkında:
StorySpace, kullanıcıların kendi hikayelerini oluşturmasına, kişiselleştirilmiş görsellerle zenginleştirmesine ve bu hikayeleri arkadaşlarıyla paylaşmasına olanak tanıyan bir iOS uygulamasıdır. Uygulama, OpenAI'nin GPT ve DALL-E modellerini kullanarak yaratıcı içerikler üretir. Firebase ile kullanıcı doğrulaması, veri depolama ve dosya yükleme işlemleri yönetilir.

## Özellikler:

Kullanıcı Girişi ve Üye Olma: Firebase Authentication ile kullanıcılar güvenli bir şekilde giriş yapabilir ve hesap oluşturabilirler.

Hikaye Oluşturma: Kullanıcılar, seçtikleri tema, karakter özellikleri, olay ve diğer detaylarla hikaye oluşturabilir.

Görsel Oluşturma: OpenAI'nin DALL-E modeliyle oluşturulan hikayeye uygun görsel içerik eklenir.

Hikaye Paylaşma: Oluşturulan hikayeler, arkadaşlarınızla paylaşmak için paylaş butonu ile desteklenir.

Hikaye Kaydetme: Oluşturulan hikayeler ve görseller Firebase Firestore ve Firebase Storage'da saklanır.

Görsel ve Veritabanı Yönetimi: Firebase Storage'da görseller saklanırken, Firestore'da hikaye detayları depolanır.

## Teknolojiler:

### SwiftUI: Kullanıcı arayüzü.

Alamofire: OpenAI API'si ile iletişim sağlama.

SDWebImageSwiftUI: Hikaye görsellerini yükleme ve görüntüleme.

Firebase Authentication: Kullanıcı kimlik doğrulama.

Firebase Firestore: Hikaye verilerini saklama.

Firebase Storage: Görselleri saklama.

Gerekli Firebase Servisleri:

### Authentication: Kullanıcı giriş/çıkış işlemleri.

Firestore Database: Hikayelerin ve diğer verilerin saklanması.

Storage: Kullanıcı hikayelerine ait görsellerin saklanması.

Not: Firebase projesinde bu servisleri aktif etmeniz gerekmektedir.


### OpenAI API Ayarları:

OpenAI API kullanmak için bir API anahtarı oluşturun ve bunu proje kodunda ilgili yerlere ekleyin:

```
var headers: HTTPHeaders? {
    return [
        "Authorization": "Bearer YOUR_OPENAI_API_KEY",
        "Content-Type": "application/json"
    ]
}
```
DALL-E ve GPT modellerini kullanarak hikaye ve görsel oluşturun.

## Kurulum ve Kullanım:

Firebase konsolunda Authentication, Firestore Database, ve Storage servislerini etkinleştirin.
OpenAI API anahtarınızı alın ve projeye ekleyin.
Uygulamayı çalıştırarak hikaye oluşturma ve paylaşma özelliklerini kullanın.
Ekran Görüntüleri:

Firebase konsolundaki gerekli servislerin aktif edildiğine dair ekran görüntüleri için README'deki dosyaları kontrol edin.
