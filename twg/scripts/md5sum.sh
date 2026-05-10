#!/bin/bash

## check data integrity
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Burro04/; md5sum -c MD5.txt > /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Earl01/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Earl02/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Earl03/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Earl04/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Paredon02/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Pudding16/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Pudding21/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Stone03/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/Stone09/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21053023-Z01-F001/raw_data/md5sum.log
#
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Big06/; md5sum -c MD5.txt > /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Big13/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Big19/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Big20/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Big22/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Big23/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Pudding25/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Pudding31/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Pudding41/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Pudding47/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Stone30/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Stone31/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Stone32/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Stone37/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Virgin40/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Virgin45/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Virgin55/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Virgin58/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y06Virgin59/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y11Tillas14/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y11Tillas19/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y11Tillas20/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y11Tillas22/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y11Tillas37/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y11Tillas58/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/y21Pudding09/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F002/raw_data/md5sum.log
#
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Burro13/; md5sum -c MD5.txt > /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Burro15/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Burro16/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Burro19/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Burro20/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Paredon18/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Paredon28/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Paredon35/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Paredon38/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y14Paredon39/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Antonio11/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Antonio17/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Antonio18/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Antonio22/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Antonio29/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Antonio30/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Ynez13/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Ynez14/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Ynez17/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Ynez20/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Ynez25/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y17Ynez28/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y21Virgin02/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y21Virgin08/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y21Virgin09/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/y21Virgin17/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F003/raw_data/md5sum.log

cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y06Virgin49/; md5sum -c MD5.txt > /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y09Arcata20/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y11Earl09/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y11Earl10/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Big01/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Big05/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Big06/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Pudding05/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Pudding07/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Pudding10/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Pudding15/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Pudding16/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Stone01/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Stone02/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Stone04/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Stone05/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Stone07/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Stone08/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Virgin13/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log & \
cd /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/y21Virgin16/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F005/raw_data/md5sum.log

#cd /home/instr1/twg/reads/X202SC21101151-Z01-F006/raw_data/y21Big02/; md5sum -c MD5.txt > /home/instr1/twg/reads/X202SC21101151-Z01-F006/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F006/raw_data/y21Big03/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F006/raw_data/md5sum.log
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F006/raw_data/y21Big04/; md5sum -c MD5.txt >> /home/instr1/twg/reads/X202SC21101151-Z01-F006/raw_data/md5sum.log
#
#cd /home/instr1/twg/reads/X202SC21101151-Z01-F009/raw_data/y09Arcata21G/; md5sum -c MD5.txt > /home/instr1/twg/reads/X202SC21101151-Z01-F009/raw_data/md5sum.log
