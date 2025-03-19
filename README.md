# Flask Vagrant Project

Bu proje, geliştiriciler arasında tutarlı bir geliştirme ortamı sağlamak için Vagrant kullanarak bir Flask uygulamasını çalıştırma amacıyla oluşturulmuştur.

## Gereksinimler

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

## Kurulum

1. Repoyu klonlayın:
```
git clone https://github.com/emredevops37/flask-vagrant-project.git
cd flask-vagrant-project
```
2. Vagrant VM'i başlatın:
```
vagrant up
```
3. VM başlatıldıktan sonra, uygulama otomatik olarak çalışacaktır.

## Erişim

- Flask Development Server: [http://localhost:5000](http://localhost:5000)
- Gunicorn + Nginx: [http://localhost:8080](http://localhost:8080)

## Geliştirme

- Kod değişikliklerini yerel makinenizde yapabilirsiniz, değişiklikler VM'e otomatik olarak senkronize edilecektir.