#!/bin/bash
# E4S 인퍼런스용 conda 가상 환경 설정 스크립트 (RunPod 환경)
# INSTALLATION.md 기준으로 작성

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

echo "=========================================="
echo "E4S conda 환경 설정 시작 (RunPod)"
echo "=========================================="

# 1. conda 사용 가능 여부 확인
if ! command -v conda &> /dev/null; then
    echo "오류: conda가 설치되어 있지 않습니다. Miniconda/Anaconda를 먼저 설치해주세요."
    exit 1
fi

# 2. e4s_env.yaml로 conda 환경 생성
# INSTALLATION.md: conda env create -f e4s_env.yaml
if conda env list | grep -q "^e4s "; then
    echo "이미 'e4s' 환경이 존재합니다. 재생성하려면 먼저 'conda env remove -n e4s' 실행 후 다시 시도하세요."
    read -p "기존 환경을 삭제하고 새로 만들까요? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        conda env remove -n e4s -y
    else
        echo "설치를 건너뜁니다."
        exit 0
    fi
fi

echo "conda 환경 생성 중 (e4s_env.yaml)..."
conda env create -f e4s_env.yaml

echo ""
echo "=========================================="
echo "환경 생성 완료."
echo "=========================================="
echo ""
echo "아래 명령으로 환경을 활성화한 뒤 인퍼런스를 실행하세요:"
echo "  conda activate e4s"
echo "  cd $REPO_ROOT"
echo ""
echo "예: face edit 실행"
echo "  python scripts/face_edit.py --help"
echo ""
echo "※ 사전학습 모델은 INSTALLATION.md 1.2, 1.3절 참고해 pretrained_ckpts/ 에 다운로드해주세요."
echo ""
