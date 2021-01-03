#!/bin/bash
read -p "user: " usuario
su -s /bin/bash -c "passwd" $usuario
