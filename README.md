# C++ CMake 프로젝트 템플릿

이 저장소는 `copier`를 사용하여 빠르고 표준화된 모던 C++ 프로젝트 틀을 생성하기 위한 템플릿입니다.

## 🚀 시작하기 전에

### 1. Copier 설치

```bash
uv tool install copier
```

### 2. 빌드 시스템 설치

```bash
# Ninja (권장)
sudo apt install ninja-build

# 또는 기본 Make (별도 설치 불필요, build-essential에 포함)
```

### 3. 컴파일러 설치

```bash
# GCC (권장)
sudo apt install build-essential

# 또는 Clang
sudo apt install clang
```

### 4. Doxygen 설치 (문서 자동화, 선택 사항)

```bash
sudo apt install doxygen graphviz
```

### 5. vcpkg 설치 (C++ 패키지 매니저)

```bash
git clone https://github.com/microsoft/vcpkg.git ~/vcpkg
~/vcpkg/bootstrap-vcpkg.sh
```

설치 후 `VCPKG_ROOT` 환경변수를 셸 설정 파일(`.bashrc`, `.zshrc` 등)에 추가합니다.

```bash
export VCPKG_ROOT="$HOME/vcpkg"
```

> `CMakePresets.json`이 `$env{VCPKG_ROOT}`를 참조하므로 반드시 설정되어 있어야 합니다.

---

## 🛠 사용법

새 프로젝트를 생성할 디렉토리에서 아래 명령어를 실행합니다.

```bash
# 로컬 템플릿 사용
copier copy --trust <이_템플릿이_있는_경로> <새_프로젝트_경로>

# GitHub 템플릿 사용
copier copy gh:ramse1163/cxx_project_template <새_프로젝트_경로>
```

명령어를 실행하면 아래 항목들을 순서대로 묻습니다.
기본값이 표시되며, 변경이 없다면 Enter를 누르면 됩니다.

| 항목 | 설명 | 기본값 |
|---|---|---|
| `project_name` | 프로젝트 이름 | `Modern Cpp Project` |
| `project_slug` | 파일·폴더·CMake 타겟에 사용되는 식별자 | project_name을 소문자+언더스코어로 변환 |
| `namespace_name` | C++ 네임스페이스 이름 (짧게 변경 가능) | project_slug와 동일 |
| `author_name` | 개발자 또는 팀 이름 | `Your Name` |
| `copyright_year` | 저작권 연도 | `2026` |
| `license` | SPDX 기반 라이선스 선택 | `MIT` |
| `cpp_standard` | C++ 표준 | `20` |
| `use_ninja` | Ninja 빌드 시스템 사용 여부 | `true` |
| `compiler` | 컴파일러 선택 (`gcc` / `clang`) | `gcc` |
| `include_google_test` | Google Test + CTest 포함 여부 | `true` |

---

## 🔄 템플릿 업데이트 (copier의 핵심 기능)

기존에 생성한 프로젝트에 템플릿 변경사항을 반영할 수 있습니다.

```bash
# 생성된 프로젝트 디렉토리 안에서 실행
copier update
```

---

## 💡 추천 설정

**Ninja + GCC** 조합을 권장합니다.

- **Ninja**: Make 대비 빌드 속도가 빠르며, 규모가 커질수록 효과가 큽니다.
- **GCC**: 안정성이 검증된 컴파일러로, 이 템플릿의 기본 설정이 GCC 기준으로 구성되어 있습니다.

개발 IDE로는 **VS Code**를 권장합니다. 생성되는 `.vscode/` 폴더가 IntelliSense, CMake 빌드, 디버깅 설정을 자동으로 제공합니다.

---

## 📁 생성되는 프로젝트 구조

```text
<project_slug>/
├── CMakeLists.txt        # 최상위 CMake 설정
├── CMakePresets.json     # Debug / Release 빌드 프리셋 (+ 테스트 프리셋)
├── vcpkg.json            # vcpkg 의존성 목록
├── README.md             # 생성된 프로젝트 설명서
├── apps/                 # 실행 파일 소스 (main.cpp)
├── libs/                 # 모듈별 라이브러리 소스
│   ├── math/
│   └── utility/
├── tests/                # Google Test 기반 유닛 테스트 (include_google_test: true 시 활성화)
├── docs/                 # Doxygen 문서 설정
├── .gitignore
└── .vscode/              # VS Code 빌드·디버그·IntelliSense 설정
```

### 각 폴더 역할

- **`apps/`**: `main()` 함수가 있는 실행 바이너리. `libs/`의 코드를 가져다 사용하도록 가볍게 유지합니다.
- **`libs/`**: 기능별로 모듈화된 핵심 비즈니스 로직. 외부 프로젝트에서도 링크할 수 있도록 설계합니다.
- **`tests/`**: `libs/`의 유닛 테스트. GTest로 작성하고 CTest로 실행합니다.
