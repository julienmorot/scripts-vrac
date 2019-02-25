#!/bin/bash

#man 4 console_codes

echo "### Colorisation ###"
for bg in {40..47} {100..107} 49 ; do
	for fg in {30..37} {90..97} 39 ; do
		echo -ne "\e[${bg};${fg}m ${bg};${fg}\e[${bg};${fg}m\e[0m\c"
	done
	echo ""
done
echo ""
echo "### Formattage ###"
echo ""
echo -e "\e[0mNormal"
echo -e "\e[1mGras\e[0m"
echo -e "\e[2mFaible\e[0m"
echo -e "\e[4mSouligné\e[0m"
echo -e "\e[5mClignotant\e[0m"
echo -e "\e[7mCouleurs inversées\e[0m"
echo -e "\e[8mMasqué\e[0m"

exit 0
