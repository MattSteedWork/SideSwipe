# SideSwipe - Automated Tool For HTB/THM


SideSwipe is an automated tool for CTFs. 

When prompted input the project name and the ip address and SideSwipe does the following...

1.Creates Directories For Results\
2.Runs a Quick Nmap Scan\
3.Checks The Results of The Scan For Ports 80,445,8080\
4.If 445 is Found SideSwipe Runs Smbclient\
5.If port 80 or 8080 is found SideSwipe Runs Feroxbuster in a seperate window  
  
!!Be sure to change the terminal in the code if you dont have Konsole!!  

Have fun.

