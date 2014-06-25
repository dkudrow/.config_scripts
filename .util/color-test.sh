for i in {0..255}
do
	if ! (( i % 16 ))
	then
		echo
	fi
	printf "\x1b[38;5;${i}m${i} "
done
