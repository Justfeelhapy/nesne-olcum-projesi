# MATLAB GUI Tabanlı Nesne Ölçüm Sistemi

Bu projede MATLAB kullanılarak grafik arayüzlü (GUI) bir nesne ölçüm sistemi geliştirilmiştir.  
Sistem, bir görüntü üzerinden referans olarak seçilen 1 TL madeni para yardımıyla
nesnelerin yaklaşık boyutlarını santimetre cinsinden hesaplamaktadır.

---

## Projenin Amacı
Bu çalışmanın amacı, görüntü işleme teknikleri kullanarak
piksel tabanlı ölçümleri gerçek dünya ölçülerine dönüştüren
kullanıcı dostu bir MATLAB arayüzü geliştirmektir.

---

## Kullanılan Yöntem
- Kullanıcı bir görüntü dosyası seçer.
- Referans nesne olarak 1 TL madeni para işaretlenir.
- 1 TL’nin gerçek çapı (2.615 cm) kullanılarak piksel–cm dönüşüm oranı hesaplanır.
- Görüntü ikilileştirilerek nesne tespiti yapılır.
- En büyük nesne seçilerek genişlik, yükseklik ve çap ölçümleri hesaplanır.
- Sonuçlar hem ekranda gösterilir hem de kaydedilebilir.

---

## Arayüz Özellikleri
- Resim seçme
- Referans para seçimi
- Otomatik nesne ölçümü
- Sonuç görselini kaydetme
- Ölçüm değerlerini GUI üzerinde gösterme

---

## Klasör Yapısı
matlab-project/
├─ src/ MATLAB kaynak kodları
├─ data/ Harici veri dosyaları (bu projede kullanılmamıştır)
├─ figures/ Ölçüm sonuçlarına ait görseller
├─ docs/ Proje açıklamaları
├─ README.md
└─ LICENSE


---

## Çalıştırma Talimatları
1. MATLAB programını açın.
2. `src/` klasörüne girin.
3. `gui_butonlu_nesne_olc.m` dosyasını çalıştırın.
4. Açılan arayüz üzerinden sırasıyla:
   - Resim seçin
   - 1 TL referansını işaretleyin
   - Nesneyi ölçün
   - Sonucu kaydedin

---

## Kullanılan Araçlar ve Kütüphaneler
- MATLAB
- Image Processing Toolbox
- MATLAB GUI (uicontrol)

---

## Lisans
Bu proje MIT Lisansı ile paylaşılmıştır.



