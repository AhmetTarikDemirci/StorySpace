
<div align="center" style="display: flex; align-items: center; justify-content: center;">
  <img src="https://ahmettarikdemirci.io/story_space/screen_shoots/icon.png" alt="Logo" style="height: 200px; margin-right: 10px;">

</div>

# Proje Hakkında:
StorySpace, kullanıcıların kendi hikayelerini oluşturmasına, kişiselleştirilmiş görsellerle zenginleştirmesine ve bu hikayeleri arkadaşlarıyla paylaşmasına olanak tanıyan bir iOS uygulamasıdır. Uygulama, OpenAI'nin GPT ve DALL-E modellerini kullanarak yaratıcı içerikler üretir. Firebase ile kullanıcı doğrulaması, veri depolama ve dosya yükleme işlemleri yönetilir.

## Ekran Görüntüleri 
<div style="display: flex; overflow-x: auto;">
  <img src="https://ahmettarikdemirci.io/story_space/screen_shoots/1.png" alt="Giriş Ekranı" style="height: 300px; margin-right: 10px;">
  <img src="https://ahmettarikdemirci.io/story_space/screen_shoots/2.png" alt="Kayıt Ekranı" style="height: 300px; margin-right: 10px;">
  <img src="https://ahmettarikdemirci.io/story_space/screen_shoots/3.png" alt="Ana Ekran" style="height: 300px; margin-right: 10px;">
  <img src="https://ahmettarikdemirci.io/story_space/screen_shoots/8.png" alt="Kategori Yönetimi" style="height: 300px; margin-right: 10px;">
  <img src="https://ahmettarikdemirci.io/story_space/screen_shoots/4.png" alt="Görev Yönetimi" style="height: 300px; margin-right: 10px;">
</div>

## Özellikler:

* Kullanıcı Girişi ve Üye Olma: Firebase Authentication ile kullanıcılar güvenli bir şekilde giriş yapabilir ve hesap oluşturabilirler.

* Hikaye Oluşturma: Kullanıcılar, seçtikleri tema, karakter özellikleri, olay ve diğer detaylarla hikaye oluşturabilir.

* Görsel Oluşturma: OpenAI'nin DALL-E modeliyle oluşturulan hikayeye uygun görsel içerik eklenir.

* Hikaye Paylaşma: Oluşturulan hikayeler, arkadaşlarınızla paylaşmak için paylaş butonu ile desteklenir.

* Hikaye Kaydetme: Oluşturulan hikayeler ve görseller Firebase Firestore ve Firebase Storage'da saklanır.

* Görsel ve Veritabanı Yönetimi: Firebase Storage'da görseller saklanırken, Firestore'da hikaye detayları depolanır.

## Teknolojiler:

### SwiftUI: Kullanıcı arayüzü.

* Alamofire: OpenAI API'si ile iletişim sağlama.

* SDWebImageSwiftUI: Hikaye görsellerini yükleme ve görüntüleme.

* Firebase Authentication: Kullanıcı kimlik doğrulama.

* Firebase Firestore: Hikaye verilerini saklama.

* Firebase Storage: Görselleri saklama.

* Gerekli Firebase Servisleri:

### Authentication: Kullanıcı giriş/çıkış işlemleri.

Firestore Database: Hikayelerin ve diğer verilerin saklanması.

Storage: Kullanıcı hikayelerine ait görsellerin saklanması.

Not: Firebase projesinde bu servisleri aktif etmeniz gerekmektedir.

<h2>🛠️ Kurulum:</h2>

### OpenAI API Ayarları:

1. OpenAI API Anahtarı Almak:
   
    * OpenAI'nin resmi web sitesine gidin.
    * Bir hesap oluşturun veya mevcut hesabınızla giriş yapın.
    * Hesabınıza giriş yaptıktan sonra, API anahtarınızı almak için "API Keys" bölümüne gidin.
    * Yeni bir API anahtarı oluşturun ve bu anahtarı güvenli bir yerde saklayın.
  
2. API Anahtarını Projeye Ekleme:
  
    * Proje dosyalarınızda headers değişkenine API anahtarınızı aşağıdaki şekilde ekleyin.
    * YOUR_OPENAI_API_KEY kısmını kendi API anahtarınızla değiştirin.

```
var headers: HTTPHeaders? {
    return [
        "Authorization": "Bearer YOUR_OPENAI_API_KEY",
        "Content-Type": "application/json"
    ]
}
```
    
### Firebase Kurulumu (Swift Package Manager ile):
1. Firebase Projesi Oluşturma:

    * Firebase'in resmi web sitesine gidin ve giriş yapın.
    * Yeni bir proje oluşturun ve gerekli adımları tamamlayın.
      
2. Firebase Servislerini Aktif Etme:

    * Proje ayarlarında "Authentication" bölümüne gidin ve Email/Password doğrulamasını etkinleştirin.
    * "Firestore Database" bölümüne gidin ve veritabanını oluşturun. Veritabanını 'Production' modda başlatın.
    * "Storage" bölümüne gidin ve bir depolama alanı oluşturun.
      
3. Firebase SDK'yı Xcode Projenize Ekleyin (SPM ile):

    * Xcode projenizi açın.
    * Menüden File > Add Packages... seçeneğini tıklayın.
    * Açılan pencereye Firebase'in resmi Swift Package URL'sini girin: https://github.com/firebase/firebase-ios-sdk.
    * İlgili Firebase modüllerini seçin ve projenize ekleyin. Örneğin:
    * Firebase/Auth: Kullanıcı kimlik doğrulaması için.
    * Firebase/Firestore: Hikaye verilerini saklama için.
    * Firebase/Storage: Görselleri saklama için.

4. Firebase Yapılandırması:

    * Firebase konsolunda, iOS uygulamanızı Firebase projenize ekleyin ve gerekli GoogleService-Info.plist dosyasını indirin.
    * Bu dosyayı Xcode projenize ekleyin.

5. Projenizi Çalıştırın:

Xcode'da projenizi derleyin ve çalıştırın. Firebase servisleri artık entegre olmuştur.

<h2>💖Projemi beğendiniz mi?</h2>

Merhaba!
StorySpace projesini kullanarak kendi yaratıcı hikayelerinizi oluşturduğunuz için teşekkür ederiz. Bu proje yaratıcı içeriği destekleyen açık kaynaklı bir girişimdir ve sürekli geliştirilmekte ve iyileştirilmektedir. Eğer projeyi beğendiyseniz ve daha fazla geliştirilmesini istiyorsanız lütfen projeye yıldız vermekten çekinmeyin ve bu projeyi paylaşarak daha fazla kişinin faydalanmasını sağlayın. 

Destek Olmak İçin: 
* GitHub'da Yıldız Verin Proje hakkında geri bildirimde bulunun veya katkıda bulunun.
*  Projeyi sosyal medyada paylaşarak daha fazla kişinin haberdar olmasını sağlayın.
*  Her türlü destek bu projeyi daha iyi hale getirmek için çok değerlidir.
*  Bağış yaparak projenin geliştirilmesine katkıda bulunun.
  <div align="leading">
            <a href="https://www.buymeacoffee.com/ahmettarikdemirci" target="_blank" style="display: inline-block;">
                <img
                    src="https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-orange.svg?style=flat-square&logo=buymeacoffee" 
                    align="center"
                />
            </a></div>
<br />

Teşekkürler!

<h3 align="center">Benimle iletişime geçin:</h3>
<p align="center">
<a href="mailto:ahmettarikdemirci@icloud.com" target="blank"><img align="center" src="https://ahmettarikdemirci.io/todolist/screen_shoots/mail.png" alt="ahmettarikdemirci@gmail.com" height="40" width="40" /></a>
<a href="https://linkedin.com/in/ahmet-tar%c4%b1k-demirci" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="ahmet-tar%c4%b1k-demirci" height="30" width="40" /></a>
<a href="https://instagram.com/ahmettarikdemirci" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/instagram.svg" alt="ahmettarikdemirci" height="30" width="40" /></a>
<a href="https://www.youtube.com/@user-tm8ri2tk9c" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/youtube.svg" alt="@user-tm8ri2tk9c" height="30" width="40" /></a>
</p>

<br/>  

<div align="center">
            <a href="https://www.buymeacoffee.com/ahmettarikdemirci" target="_blank" style="display: inline-block;">
                <img
                    src="https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-orange.svg?style=flat-square&logo=buymeacoffee" 
                    align="center"
                />
            </a></div>
<br />

