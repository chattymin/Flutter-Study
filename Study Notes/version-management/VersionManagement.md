# FVM
Flutter Version Management : Flutter SDK 설치 및 버전 관리 도구

## Install

### MacOS
```bash
// brew가 있을 경우
brew install fvm

// 없을 경우
curl -fsSL https://fvm.app.install.sh | bash
```

### Window
```bash
choco install fvm
```


## 개발 환경 세팅 fvm 명령어
```bash
// 사용 가능한 버전 목록
fvm release

// 사용할 버전 설치
fvm install stable

// stable 버전으로 global 버전 설정
fvm global stable
```

## 프로젝트 생성 이후
프로젝트 FVM을 초기화 해준다.    
해당하는 프로젝트 터미널에서 아래와 같은 명령어를 입력해준다

```bash
fvm use stable
```
