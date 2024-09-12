FROM ubuntu:20.04

# Update dan install xfce4 desktop environment, xrdp (untuk RDP), wget, dan unzip
RUN apt-get update && \
    apt-get install -y xfce4 xrdp wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Tambahkan user 'henz' dan set password 'henz4321'
RUN useradd -m -s /bin/bash henz && echo "henz:henz4321" | chpasswd

# Konfigurasi xrdp untuk menggunakan xfce4
RUN echo "xfce4-session" > /home/henz/.xsession

# Install Ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    mv ngrok /usr/local/bin && \
    rm ngrok-stable-linux-amd64.zip

# Tambahkan token Ngrok (ganti <YOUR_NGROK_TOKEN> dengan token kamu)
RUN ngrok authtoken 2gJOKxrR6ToUmUJmwnHvmUEMI7O_7CaFybHTiRnhKAGU3tERi

# Expose port 3389 untuk RDP
EXPOSE 3389

# Start xrdp dan Ngrok untuk forward port 3389
CMD /etc/init.d/xrdp start && ngrok tcp 3389 && tail -f /dev/null
