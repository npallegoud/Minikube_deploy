#! /bin/bash
#color notes
NC='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
cyan='\033[0;36m'
yellow='\033[0;33m'

clear

echo -e "${YELLOW}---------------------------------------------------------------------------------------------------------------${NC}"
echo "APPLICATION STATUS MONITOR"
echo -e "${YELLOW}---------------------------------------------------------------------------------------------------------------${NC}"

result=$(curl http://10.50.47.75:31115)

echo -e "${YELLOW}---------------------------------------------------------------------------------------------------------------${NC}"
if [ "$result" == "<h1>Hello from the Backend!</h1>" ]
then
   echo  -e "${GREEN}The Demo Site integration working {NC}"
else
   echo -e "${RED}The Demo Site integration not working {NC}"
fi
echo -e "${YELLOW}---------------------------------------------------------------------------------------------------------------${NC}"
