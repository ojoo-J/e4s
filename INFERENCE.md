# E4S Face Swap 인퍼런스 (배치)

## 경로 (기본값)

| 항목 | 경로 |
|------|------|
| Source 데이터 | `/workspace/data/preproc_source` |
| Target 데이터 | `/workspace/data/FFHQ/ffhq_safe_real` |
| Face swap 결과 | `/workspace/e4s/results` |

## 실행 방법

1. conda 환경 활성화 후 e4s 루트에서 실행:

```bash
conda activate e4s
cd /workspace/e4s
bash run_batch_faceswap.sh
```

2. 위 기본 경로를 쓰지 않을 때는 환경 변수로 지정:

```bash
SOURCE_DIR=/path/to/sources TARGET_DIR=/path/to/targets OUTPUT_DIR=/path/to/out bash run_batch_faceswap.sh
```

## 동작

- `SOURCE_DIR`와 `TARGET_DIR`에서 이미지 파일(.jpg, .jpeg, .png, .bmp)을 **이름순**으로 읽습니다.
- 같은 순서끼리 1:1로 매칭해 face swap을 수행합니다.
- 결과 파일은 `OUTPUT_DIR`에 `swap_<source명>_to_<target명>.png` 형식으로 저장됩니다.
- 쌍 개수는 두 폴더 중 **적은 쪽** 기준입니다.

## 단일 쌍만 실행

```bash
cd /workspace/e4s
python scripts/face_swap.py \
  --source /workspace/data/preproc_source/원하는소스.jpg \
  --target /workspace/data/FFHQ/ffhq_safe_real/원하는타깃.jpg \
  --output_dir /workspace/e4s/results
```

사전학습 모델은 `INSTALLATION.md`에 따라 `pretrained_ckpts/`에 준비되어 있어야 합니다.
