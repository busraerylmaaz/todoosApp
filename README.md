![todoos](https://raw.githubusercontent.com/busraerylmaaz/todoosApp/main/assets/images/logo.png)


**todoos**, kullanıcıların görevlerini kolayca yönetmelerini sağlayan bir görev yönetim uygulamasıdır. Bu uygulama, görevlerinizi eklemenize, düzenlemenize, tamamlamanıza ve silmenize olanak tanır. Kullanıcı dostu arayüzü sayesinde görevlerinizi hızlı ve verimli bir şekilde organize edebilirsiniz.

todoos, kullanıcıların uygulamaya Google hesaplarıyla veya e-posta adresleriyle giriş yapmalarına imkan tanır. Verilerinizi güvenli ve düzenli bir şekilde yönetmek için _Firestore_ veritabanını kullanır. Ayrıca, uygulama üzerinden tamamlanan ve bekleyen görevlerinizi ayrı ayrı görüntüleyebilir, görevlerinizi arayabilir ve sıralayabilirsiniz.



## Özellikler

### Giriş Seçenekleri
- ✉️**E-posta ile Giriş:** Kullanıcılar, e-posta adreslerini kullanarak güvenli bir şekilde uygulamaya giriş yapabilirler.
- ✉️ **Google ile Giriş:** Google hesapları ile hızlı ve kolay bir şekilde giriş yapma imkanı.

### Görev Sayfaları
-📋**Bekleyen Görevler (Pending):** Kullanıcıların henüz tamamlamadığı tüm görevleri listeler. Bu sayfa, kullanıcıların tamamlanmamış görevlerini kolayca takip etmelerini sağlar.

-✅ **Tamamlanmış Görevler(Completed):** Kullanıcıların tamamladığı görevleri gösterir. Bu sayfa, kullanıcıların geçmişte tamamladıkları görevleri görmelerine olanak tanır ve başarılarını takip etmelerini sağlar.

### Arama Özelliği
- 🔍 **Görev Arama:** Kullanıcılar, görevlerin arasında hızlıca arama yapabilirler. Bu özellik, belirli bir görevi bulmayı kolaylaştırır ve zaman kazandırır.

### CRUD İşlemleri
- ➕ **Görev Ekleme:** Kullanıcılar yeni görevler ekleyebilirler. Bu özellik, kullanıcıların görevlerini düzenli bir şekilde yönetmelerine yardımcı olur.
- ✏️ **Görev Düzenleme:** Mevcut görevleri düzenleyebilir ve güncelleyebilirsiniz. Bu sayede, kullanıcılar görevlerde değişiklik yapabilir ve güncel tutabilirler.
- 🗑️ **Görev Silme:** Kullanıcılar artık ihtiyaç duymadıkları görevleri silebilirler. Bu, görev listelerinin temiz ve düzenli kalmasını sağlar.

- ✅**Görev Tamamlama:** Kullanıcılar tamamladıkları görevleri işaretleyebilirler. Bu özellik, kullanıcıların ilerlemelerini takip etmelerini ve motivasyonlarını yüksek tutmalarını sağlar.

### Sıralama
- 🔄 **Görev Sıralama:** Görevler, Firestore veritabanı aracılığıyla en son eklenen görevden en eskiye doğru sıralanır. Bu, kullanıcıların en güncel görevlerini öncelikli olarak görmelerine olanak tanır ve görev yönetimini daha verimli hale getirir.

## Görseller


### Ana Ekran
![Ana Ekran](https://r.resimlink.com/97KZsVc2qky.png)



### Görev Ekleme
![Görev Ekleme](https://r.resimlink.com/Qm3AzYadl4.png)

### Görev Listesi
![Görev Listesi](https://r.resimlink.com/yKcP13.png)

### Görev Tamamlama
![Görev Tamamlama](https://r.resimlink.com/NmaYCe1L.png)

![](https://r.resimlink.com/PoMFEsi2Cq.png)



![](https://r.resimlink.com/PuZECzlJ.png)

## Teknolojiler

- **Flutter:** Mobil uygulama geliştirme için kullanılan açık kaynaklı UI SDK'sı.
- **Dart:** Flutter uygulamaları için kullanılan programlama dili.
- **Visual Studio Code (VSCode):** Dart ve Flutter geliştirmeleri için kullanılan kod editörü.
- **Firebase Authentication:** E-posta ve Google ile kullanıcı kimlik doğrulama işlemleri.
- **Firebase Firestore:** Görevlerin depolanması ve yönetimi için kullanılan veritabanı.



## Kurulum

Bu adımları takip ederek **todoos** uygulamasını yerel olarak kurabilir ve çalıştırabilirsiniz.

### Gereksinimler
- **Flutter:** [Flutter SDK](https://flutter.dev/docs/get-started/install) yüklenmiş olmalıdır.
- **Dart:** Flutter ile birlikte otomatik olarak yüklenir.
- **Visual Studio Code (VSCode):** [VSCode](https://code.visualstudio.com/) yüklenmiş olmalıdır.
- **Firebase:** Firebase projesi oluşturulmalı ve yapılandırılmalıdır.

### Kurulum Adımları
1. Depoyu Klonlayın:

   
bash
   git clone https://github.com/busraerylmaaz/todoos.git


2. Proje Dizini İçine Gidin:
bash
   cd todoos


3. Flutter Paketlerini Yükleyin:
   
bash
   flutter pub get
   
4. Firebase Yapılandırmasını Yapın:

Firebase projesi oluşturun ve Firebase Console üzerinden gerekli API anahtarlarını ve yapılandırma dosyalarını (google-services.json ve/veya GoogleService-Info.plist) indirin.

İlgili yapılandırma dosyalarını projenizin android/app ve ios/Runner dizinlerine ekleyin.

5. Uygulamayı Çalıştırın:
bash
   flutter run



## İletişim 💬

- **E-posta:** [erylmzbsr@gmail.com](mailto:erylmzbsr@gmail.com)
- **GitHub:** [busraerylmaaz/todoos](https://github.com/busraerylmaaz/todoos)
