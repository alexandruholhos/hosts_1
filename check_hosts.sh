#!/bin/bash

while read -r ip name_list; do
    
    [ -z "$ip" ] && continue
    case "$ip" in
        \#*) continue ;;
    esac

    
    if [ -n "$name_list" ]; then
        
        set -- $name_list
        name="$1"

        resolved_ip=$(nslookup "$name" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n1)        
        if [ -n "$resolved_ip" ] && [ "$resolved_ip" != "$ip" ]; then
            echo "Bogus IP for $name in /etc/hosts!"
        fi
    fi
done < /etc/hosts
