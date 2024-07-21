#!/bin/sh

PW_PATH=/SDServer

if [ ! -d $PW_PATH/logs ]; then
mkdir $PW_PATH/logs
fi
cat /dev/null > $PW_PATH/logs/syslog

echo "===============================================================" 
echo "=             STARTING Saint Seiya Server                     =" 
echo "=             SERVER LOADING WILL TAKE SOME TIME              =" 
echo "===============================================================" 
date 

echo "=== LOGSERVICE ===" 
cd $PW_PATH/logservice; ./logservice logservice.conf &
echo "=== DONE! ===" 
echo "" 
echo "=== UNIQUENAMED ===" 
cd $PW_PATH/uniquenamed; ./uniquenamed gamesys.conf &
echo "=== DONE! ===" 
echo "" 
echo "=== AUTH ===" 
#cd $PW_PATH/authd/build/; ./authd >> $PW_PATH/logs/authd.log 2>&1 &
cd $PW_PATH/authd/build; ./authd > $PW_PATH/logs/authd.log &
sleep 1
echo "=== DONE! ===" 
echo "" 
echo "=== GAMEDBD ===" 
cd $PW_PATH/gamedbd; ./gamedbd gamesys.conf  &
sleep 1
echo "=== DONE! ===" 
echo "" 
echo "=== BACKDBD ===" 
cd $PW_PATH/backdbd; ./backdbd gamesys.conf &
sleep 1
echo "=== DONE! ===" 
echo "" 
echo "=== GACD ===" 
cd $PW_PATH/gacd; ./gacd gamesys.conf  &
sleep 1
echo "=== DONE! ===" 
echo "" 
echo "=== GQUERYD ===" 
cd $PW_PATH/gqueryd; ./gqueryd gamesys.conf  &
sleep 1
echo "=== DONE! ===" 
echo "" 
echo "=== GDELIVERYD ===" 
cd $PW_PATH/gdeliveryd; ./gdeliveryd gamesys.conf &

echo "" 
echo "=== GLINKD ===" 
cd $PW_PATH/gamelink; ./gamelink gamesys.conf 1 > $PW_PATH/logs/gamelink.log &
#cd $PW_PATH/gamelink; ./gamelink gamesys.conf 2 > $PW_PATH/logs/gamelink.log &
#cd $PW_PATH/gamelink; ./gamelink gamesys.conf 3 > $PW_PATH/logs/gamelink.log &
#cd $PW_PATH/gamelink; ./gamelink gamesys.conf 4 > $PW_PATH/logs/gamelink.log &
sleep 1
echo "=== DONE! ===" 
echo "" 

cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias.conf > $PW_PATH/logs/game1.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias2.conf > $PW_PATH/logs/game2.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias3.conf > $PW_PATH/logs/game3.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias4.conf > $PW_PATH/logs/game4.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias5.conf > $PW_PATH/logs/game5.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias6.conf > $PW_PATH/logs/game6.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias7.conf > $PW_PATH/logs/game7.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias8.conf > $PW_PATH/logs/game8.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias9.conf > $PW_PATH/logs/game9.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias10.conf > $PW_PATH/logs/game10.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias11.conf > $PW_PATH/logs/game11.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias12.conf > $PW_PATH/logs/game12.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias13.conf > $PW_PATH/logs/game13.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias14.conf > $PW_PATH/logs/game14.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias15.conf > $PW_PATH/logs/game15.log &

cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias31.conf > $PW_PATH/logs/game31.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias32.conf > $PW_PATH/logs/game32.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias33.conf > $PW_PATH/logs/game33.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias34.conf > $PW_PATH/logs/game34.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias35.conf > $PW_PATH/logs/game35.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias36.conf > $PW_PATH/logs/game36.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias37.conf > $PW_PATH/logs/game37.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias38.conf > $PW_PATH/logs/game38.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias39.conf > $PW_PATH/logs/game39.log &
cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias40.conf > $PW_PATH/logs/game40.log &
# ALTERAR PRA PEGAR DO 0 ATÉ O 15 (pula o 1)
# DEPOIS ADICIONAR DO 31 AO 40


#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias13.conf > $PW_PATH/logs/game13.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias120.conf > $PW_PATH/logs/game102.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias103.conf > $PW_PATH/logs/game103.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias104.conf > $PW_PATH/logs/game104.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias105.conf > $PW_PATH/logs/game105.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias106.conf > $PW_PATH/logs/game106.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias107.conf > $PW_PATH/logs/game107.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias108.conf > $PW_PATH/logs/game108.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias109.conf > $PW_PATH/logs/game109.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias110.conf > $PW_PATH/logs/game110.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias111.conf > $PW_PATH/logs/game111.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias112.conf > $PW_PATH/logs/game112.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias113.conf > $PW_PATH/logs/game113.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias114.conf > $PW_PATH/logs/game114.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias115.conf > $PW_PATH/logs/game115.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias116.conf > $PW_PATH/logs/game116.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias117.conf > $PW_PATH/logs/game117.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias118.conf > $PW_PATH/logs/game118.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias119.conf > $PW_PATH/logs/game119.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias120.conf > $PW_PATH/logs/game120.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias121.conf > $PW_PATH/logs/game121.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias122.conf > $PW_PATH/logs/game122.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias123.conf > $PW_PATH/logs/game123.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias124.conf > $PW_PATH/logs/game124.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias125.conf > $PW_PATH/logs/game125.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias126.conf > $PW_PATH/logs/game126.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias127.conf > $PW_PATH/logs/game127.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias128.conf > $PW_PATH/logs/game128.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias129.conf > $PW_PATH/logs/game129.log &
#cd $PW_PATH/gamed; ./gs gs.conf gmserver.conf gsalias130.conf > $PW_PATH/logs/game130.log &




echo "===============================================================" 
echo "=                      ALL REALMS LOADED!                     =" 
echo "=                 SERVERS ARE UP AND RUNNING!                 =" 
echo "===============================================================" 

cd /SDServer/jakarta/bin; ./startup.sh &


echo "=== Realm #1 ===" 

sleep 1
echo "=== DONE! ==="


