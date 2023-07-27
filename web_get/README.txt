1.0.0.127          -> 16777343 (decimal) -> 0x100007f (hexadecimal)
08	               -> 0x0050 (hexadecimal)
Reverse byte order -> 0x5000

Read it backwards 💡 (Little endian)

Host: 127.0.0.1
Port: 80

Also don't forget to start a webserver to test the binary, with the same port (by default it is the same but just incase).
Fine, I'll even tell you how to: 

sudo apt install apache2 && service apache2 start

I'm assuming you use a Debian (or similar, like Ubuntu) based system.
