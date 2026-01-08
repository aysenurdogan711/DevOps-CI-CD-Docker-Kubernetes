# 1️⃣ Hafif ve stabil bir base image
FROM nginx:alpine

# 2️⃣ Varsayılan nginx config’i temizle
RUN rm -rf /usr/share/nginx/html/*

# 3️⃣ Uygulama dosyalarını kopyala
COPY ./html /usr/share/nginx/html

# 4️⃣ Container içi port (dokümantasyon amaçlı)
EXPOSE 80

# 5️⃣ Nginx’i foreground’da çalıştır
CMD ["nginx", "-g", "daemon off;"]
