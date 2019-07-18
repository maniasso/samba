docker run -itd -e NMBD=-n --name samba -p 139:139 -p 445:445 -p 137:137/udp -p 138:138/udp -v /torrent:/torrent maniasso/samba:latest 
