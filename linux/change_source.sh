read -p "1.change apt source | 2.get origin source (1/2):" flag
if [ $flag == "1" ]
then
	echo 1
elif [ $flag == "2" ]
then 
	echo 2
else
	echo 3
fi
sleep 1
