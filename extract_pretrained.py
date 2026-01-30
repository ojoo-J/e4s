#!/usr/bin/env python3
"""e4s.zip 내용을 pretrained_ckpts/ 구조에 맞게 풀어 넣음."""
import zipfile
import os

REPO = "/workspace/e4s"
ZIP_PATH = os.path.join(REPO, "e4s.zip")
CKPT = os.path.join(REPO, "pretrained_ckpts")

# zip 내 경로 -> pretrained_ckpts 내 목적지
MAPPING = {
    "e4s/iteration_300000.pt": "e4s/iteration_300000.pt",
    "e4s/79999_iter.pth": "face_parsing/79999_iter.pth",
    "e4s/segnext.base.best_mIoU_iter_140000.pth": "face_parsing/segnext.base.best_mIoU_iter_140000.pth",
    "e4s/00000189-checkpoint.pth.tar": "facevid2vid/00000189-checkpoint.pth.tar",
    "e4s/GPEN-BFR-512.pth": "gpen/weights/GPEN-BFR-512.pth",
    "e4s/ParseNet-latest.pth": "gpen/weights/ParseNet-latest.pth",
    "e4s/realesrnet_x4.pth": "gpen/weights/realesrnet_x4.pth",
    "e4s/RetinaFace-R50.pth": "gpen/weights/RetinaFace-R50.pth",
}

def main():
    os.makedirs(os.path.join(CKPT, "e4s"), exist_ok=True)
    os.makedirs(os.path.join(CKPT, "gpen", "weights"), exist_ok=True)
    with zipfile.ZipFile(ZIP_PATH) as z:
        for src, dst in MAPPING.items():
            if src not in z.namelist():
                print("skip (not in zip):", src)
                continue
            path = os.path.join(CKPT, dst)
            os.makedirs(os.path.dirname(path), exist_ok=True)
            with z.open(src) as f:
                data = f.read()
            with open(path, "wb") as out:
                out.write(data)
            print("ok:", dst)
    print("Done.")

if __name__ == "__main__":
    main()
