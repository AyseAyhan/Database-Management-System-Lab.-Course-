use OgrenciBilgiSistemi

CREATE TABLE Ogretmen(
ogretmen_id int primary key,
ogretmen_ad varchar(50) not null,
ogretmen_soyad varchar(50) not null,
ogretmen_brans varchar(50),
ogretmen_mail varchar(100),
ogretmen_telefon varchar(15)
);

CREATE TABLE Ogrenci(
ogrenci_id int primary key,
ogrenci_ad varchar(50) not null,
ogrenci_soyad varchar(50) not null,
ogrenci_dogum date ,
ogrenci_cinsiyet char(1) ,
ogrenci_telefon varchar(15) ,
ogrenci_mail varchar(100) ,
ogrenci_adres varchar(255) ,

);


CREATE TABLE Ders(
ders_id int identity(1,1) PRIMARY KEY,
ders_ad varchar(100) not null,
kredi int ,
bolum varchar(50) ,
ogretmen_id int,
CONSTRAINT fk_ogretmen_id FOREIGN KEY (ogretmen_id) REFERENCES Ogretmen(ogretmen_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Sinav_Sonuc(
sonuc_id int primary key,
ogrenci_id int,
CONSTRAINT fk_ogrenci_id FOREIGN KEY (ogrenci_id) REFERENCES Ogrenci(ogrenci_id) ON DELETE CASCADE ON UPDATE CASCADE,
ders_id int,
CONSTRAINT fk_ders_id FOREIGN KEY (ders_id) REFERENCES Ders(ders_id) ON DELETE CASCADE ON UPDATE CASCADE,
sinav_tarihi date ,
sinav_puan int ,

);
