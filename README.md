# LocalMiner-Android
🔴 Host Minecraft Java Edition Server From Your Android Phone!

# Steps
1. Download [Termux](https://www.apkmirror.com/apk/fredrik-fornwall/termux-fdroid-version/termux-fdroid-version-0-118-0-release/termux-fdroid-version-0-118-0-android-apk-download/download/) (not Google Play Store, that version is outdated and does not have openjdk-17 in Termux directly and have to go through Ubuntu)

2.  run this
```
pkg install wget -y && wget https://raw.githubusercontent.com/LocalMiner/LocalMiner-Android/main/LocalMiner.sh && bash LocalMiner.sh 
```

3. This runs a bash script, and there are a few options that you should think about (you can also leave blank to use default option if there is one):

4. Using Paper? (default/no means vanilla)

5. Using ngrok? (choose no if you have your own port-forwarding setup)

6. If yes, you need to find the authentication token after login/sign up on ngrok.com, note that this is required if you're using ngrok

7. If no, ignore the ngrok parts later and your server will be on the usual ip of localhost:25565

8. You can also choose a region, default is us but if you're in eu ping will be better if you choose eu

9. Custom paper/vanilla server jars (default is 1.18.2 for both)

### Note that for forge it's the installer jar

1. After selecting these options, it will install either paper or vanilla and leave two executables for actually starting the server and starting ngrok You can now run ./m to start the Minecraft server

2. Swipe from the left, make a new session, run ./n to start ngrok port-forwarding

3. To make a new session, swipe from the left of your screen. If you're using gesture navigation, swipe very slowly until you see the drawer pop out so you don't go back with gesture

4. Copy the URL in ngrok and use it as server URL in Minecraft, it should look something like x.tcp.ngrok.io:xxxxx, don't copy the tcp:// prefix

### 5. In the notifications, find Termux and click Acquire Wakelock (might have to expand that notification), this stops Android from killing Termux after a while. You can also run termux-wake-lock which does the same thing.

##### if any wget errors
https://www.youtube.com/watch?v=TOCpfccvEvM
