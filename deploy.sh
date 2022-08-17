#!/bin/bash
## 텍스트 변수 설정

txtrst='\033[1;37m' # White
txtred='\033[1;31m' # Red
txtylw='\033[1;33m' # Yellow
txtpur='\033[1;35m' # Purple
txtgrn='\033[1;32m' # Green
txtgra='\033[1;30m' # Gray

echo -e "${txtylw}=======================================${txtrst}"
echo -e "${txtgrn}  << 스크립트 🧐 >>${txtrst}"
echo -e "${txtylw}=======================================${txtrst}"

function repositoryPull() {
    echo -e "${txtgrn} 저장소 pull 시작... 📥${txtrst}"
    git pull
    echo -e "${txtgrn} 저장소 pull 완료! 🌈${txtrst}"
}

function gradleBuild() {
    echo -e "${txtgrn} gradle build 시작... 🐘${txtrst}"
    ./gradlew clean build
    echo -e "${txtgrn} gradle build 완료! 🐣${txtrst}"
}

function getPid() {
    echo -e "${txtgrn} 프로세스 pid 찾기... 🔍${txtrst}"
    pid=$(pgrep -a "java" | grep "subway" | awk '{print $1}')
    echo -e "${txtgrn} 프로세스 pid 찾기 완료! 🔍${txtrst}"
    echo -e "$pid" # for pipeline chaining
}

function killProcess() {
    echo -e "${txtgrn} 프로세스 종료... 🔌${txtrst}"
    kill -2 "$pid"
    echo -e "${txtgrn} 프로세스 종료 요청 완료! 😀${txtrst}"
}

function checkProcessTerminated() {
    echo -e "${txtgrn} 프로세스 종료 확인... 🔍${txtrst}"
    if [ -z "$pid" ]; then
        echo -e "${txtgrn} 프로세스 종료 확인 완료! 🔍${txtrst}"
    else
        echo -e "${txtred} 프로세스 종료 확인 실패! ⚠️${txtrst}"
    fi
}

function nohupRun() {
    echo -e "${txtgrn} nohup 실행... 🎬${txtrst}"
    nohup java -jar -Dspring.profiles.active=prod build/libs/subway-0.0.1-SNAPSHOT.jar 1> logging.log 2>&1 &
    echo -e "${txtgrn} nohup 실행 완료! ⭐️${txtrst}"
}
