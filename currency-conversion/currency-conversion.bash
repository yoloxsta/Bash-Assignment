#!/usr/bin/env bash

printf "\n[$] Currency Converter \n";

# current exchange rate
# 1 USD = 4500 MMK - default
printf "\n[-] 1 USD = 4500 MMK\n\n";

read -p "How many USD are you exchanging? " USD;

MMK=$( echo "val=($USD * 4600); scale=2; val/1" | bc -l );

printf "\n$USD dollers is equivalent to $MMK MMK.\n\n";