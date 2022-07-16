/bin/bash

if [ -z "$massa_pass" ];
        then
                read -p "Please set a password: "  massa_pass
                echo 'export massa_pass='$massa_pass >> $HOME/.profile; 
        else
                echo "Password is set!"; 
fi

massa_wallet_address=$(cd /root/massa/massa-client/ && /root/massa/massa-client/massa-client --pwd $massa_pass wallet_info | grep "Address" | awk '{ print $2 }' && cd)
while true
do
        balance=$(cd /root/massa/massa-client/ && /root/massa/massa-client/massa-client --pwd $massa_pass wallet_info | grep "Active rolls" | awk '{ print $3 }' && cd)
        int_balance=${balance%%.*}

        echo "-----"
        date
        if [ $int_balance -ge "1" ]; then
                echo "Balance: $int_balance"
        elif [ $int_balance -lt "1" ]; then
                echo "Balance: $int_balance"
                echo "Buying 1 roll:"
                buyrolls=$(cd /root/massa/massa-client/ && /root/massa/massa-client/massa-client --pwd $massa_pass buy_rolls $massa_wallet_address 1 0 && cd)
                echo $buyrolls
        fi
        echo "Done"
        echo "-----"
        echo "Waiting 1 minute"
        sleep 60
done
