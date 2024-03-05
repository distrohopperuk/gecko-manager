#! /bin/bash
#### this script is an assistance script for opensuse, to help using zypper #####

#################################################################################
echo "
                 _                                                       
  __ _  ___  ___| | _____    _ __ ___   __ _ _ __   __ _  __ _  ___ _ __ 
 / _  |/ _ \/ __| |/ / _ \  | '_   _ \ / _  |  _ \ / _  |/ _  |/ _ \  __|
| (_| |  __/ (__|   < (_) | | | | | | | (_| | | | | (_| | (_| |  __/ |   
 \__, |\___|\___|_|\_\___/  |_| |_| |_|\__,_|_| |_|\__,_|\__, |\___|_|   
 |___/                                                   |___/           "

echo ""
echo "		  opensuse (zypper) assistance" 
sleep 2
echo ""

#### the following code is to make sure the script is run by the root user #####

	if [ "$EUID" -ne 0 ]; then
    	echo ""
    	echo "			   ARE YOU ROOT???" 
    	echo "This script requires elevated privileges to run!"
   	echo ""
   	sleep 2
    	echo "	---> 'sudo ./gecko-manager.sh' <---" 
    	echo ""
    	sleep 3
    	exit 1
	fi
echo ""
################################################################################

#### loading animation #####

animate(){
    local spinner="/-\-|"
    local i 

    for i in $(seq 1 10);do
        printf "\r${spinner:i++%${#spinner}:1} LOADING..."
        sleep 0.1
    done

    printf "\r  \n"
}
animate
echo ""
################################################################################

#### main menu #####

while true; do
	clear
	######################################
	echo ""	
	echo "CHOOSE A COMMAND TO EXECUTE : "
	echo ""	
	######################################
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "1.  LIST UPDATES (zypper list-updates)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "2.  UPDATE PACKAGES (zypper update)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "3.  REFRESH ALL REPO'S (zypper refresh)" 
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "4.  CLEAN CACHE (zypper clean)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "5.  REMOVE PACKAGE LOCKS (zypper cleanlocks)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "6.  INSTALL RECOMMENDED PACKAGES (zypper install-new-recommends)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "7.  INFORMATION ABOUT A PACKAGE (zypper info)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "8.  CHECK FOR PATCHES (zypper patch-check)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "9.  INSTALL SOFTWARE/PACKAGES (zypper install)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "10. REMOVE A PACKAGE (zypper remove)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "11. LIST CONFIGURED REPOS (zypper repos)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "12. SEARCH FOR SOFTWARE/PACKAGES (zypper search)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "13. LIST RUNNING PROCESSES THAT USE DELETED FILES (zypper ps)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "14. DISTRUBTION UPGRADE (zypper dist-upgrade)"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	echo "15. Exit the script"
	echo -e "\e[32m- - - - - - - - - - - - - - - - - - - - - - - -\e[0m"
	######################################################
	read -p "CHOOSE THE COMMAND YOU WANT TO USE (1-15) : " choice
	######################################################

################################################################################
case $choice in
	1)	
		echo "" 
		echo "CHECKING FOR UPDATES. . ."
		echo ""		
		zypper -v list-updates
		if [ $? -eq 0 ]; then
		echo ""
		echo "UPDATES ARE AVAILABLE! RUN OPTION (2) TO INSTALL THEM!"
		else
		echo "NO UPDATES ARE AVAILABLE!"
		fi
		echo ""
		;;
	2)
		echo ""
		zypper -v update
		echo ""		
		;;
	3)	
		echo ""
		zypper -v refresh
		echo ""		
		;;
	4)
		echo ""
		zypper -v clean
		echo ""		
		;;
	5)
		echo ""
		zypper -v cleanlocks
		echo ""		
		;;
	6)
		echo ""
		zypper -v install-new-recommends
		echo ""		
		;;
	7)
		echo ""
		echo "ENTER THE PACKAGE NAME YOU WANT INFORMATION ON : "
		read package_name
#### use zypper info to get information about the package #####
		zypper -v info "$package_name"
#### ensure the information was retrieved successfully
		if [ $? -eq 0 ]; then
			echo "PACKAGE NAME WAS CORRECT!" 
		else 
			echo "FAILED TO GET THE PACKAGE INFORMATION PLEASE CHECK THE NAME WAS CORRECT, AND TRY AGAIN!"
		fi
		echo ""		
		;;
	8)
		echo ""
		zypper -v patch-check
		echo ""		
		;;
	9)
		echo ""
		echo "ENTER THE NAME OF THE SOFTWARE/PACKAGE YOU WANT TO INSTALL : "
		read package_name
		echo ""
#### use zypper install, to install the package ####
		sudo zypper -v install "$package_name" 
		echo ""
#### ensure the package was installed correctly #####
		if [ $? -eq 0 ]; then
			echo "PACKAGE $package_name HAS BEEN INSTALLED SUCCESSFULLY!"
		else
			echo "FAILED TO INSTALL $package_name PLEASE CHECK THE NAME WAS CORRECT, AND TRY AGAIN!"
		fi
		echo ""		
		;;
	10)
		echo ""
		echo "ENTER THE NAME OF THE PACKAGE YOU WANT TO REMOVE : "
		read package_name
		echo ""
##### use zypper remove to 'remove' the package #####
		sudo zypper -v remove "$package_name"
		echo ""
#### ensure the package was removed correctly #####
		if [ $? -eq 0 ]; then
			echo "PACKAGE $package_name WAS REMOVED SUCCESSFULLY!"
		else 
			echo "FAILED TO REMOVE $package_name PLEASE CHECK THE NAME WAS CORRECT, AND TRY AGAIN!"
		fi
		echo ""		
		;;
	11)
		echo ""
		zypper -v repos
		echo ""		
		;;
	12)
		echo ""		
		echo "ENTER THE NAME OF THE PACKAGE YOU WANT TO SEARCH FOR : "
		read package_name
		echo ""		
#### use zypper search, to 'search' for the package #####
		sudo zypper -v search "$package_name"
		echo ""		
#### ensure the package was removed correctly #####
		if [ $? -eq 0 ]; then
			echo "FOUND THE PACKAGE $package_name YOU WERE SEARCHING FOR!"
		else
			echi "FAILED TO FIND $package_name PLEASE CHECK THE NAME WAS CORRECT, AND TRY AGAIN!"
		fi
		echo ""		
		;;
	13)
		echo ""		
		zypper -v ps
		echo ""		
		;;
	14) 
		echo ""		
		zypper -v dist-upgrade
		echo ""		
		;;
	15) 
		echo ""		
		echo "EXITING THE SCRIPT - GOODBYE!"
		exit 0
		;;
	*)
		echo "INVALID CHOICE! LAY OFF THE DRUGS BRO! TRY AGAIN (1-15)"
		;;
	esac

	read -p "PRESS ANY BUTTON TO CONTINUE. . ."
done
################################################################################












