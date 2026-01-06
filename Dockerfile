# Hafif ve güvenilir bir ev sahibi
FROM nginx:alpine

# Varsayılan nginx static klasörünü temizle
RUN rm -rf /usr/share/nginx/html/*

# Repo içindeki index.html'i nginx'e kopyala
COPY index.html /usr/share/nginx/html/index.html

# Nginx 80 portundan yayın yapar
EXPOSE 80

# Nginx zaten default olarak foreground'da çalışır
CMD ["nginx", "-g", "daemon off;"]
