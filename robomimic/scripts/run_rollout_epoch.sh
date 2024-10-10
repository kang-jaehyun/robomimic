#!/bin/bash

# 입력받은 첫 번째 인자가 폴더 경로로 사용됩니다.
FOLDER=$1
SEED=$2
NAME=$3
TARGET_EPOCH=$4

# if seed is not provided, set it to 0
if [ -z "$SEED" ]; then
  SEED=0
fi

# if name is not provided, set it to "default"
if [ -z "$NAME" ]; then
  NAME="default"
fi

# 모델 파일들이 있는 경로 설정
MODEL_DIR="$FOLDER/models"

# config 파일 경로 설정
CONFIG_FILE="$FOLDER/config.json"

# 모델 파일이 있는 디렉토리가 존재하는지 확인
if [ ! -d "$MODEL_DIR" ]; then
  echo "Error: Model directory not found: $MODEL_DIR"
  exit 1
fi

# 모델 디렉토리 안의 모든 model_epoch_*.pth 파일에 대해 반복 실행
for MODEL_FILE in "$MODEL_DIR"/model_epoch_*.pth; do
  if [ -f "$MODEL_FILE" ]; then
    # 파일명에서 epoch 숫자 추출 (model_epoch_XXX.pth에서 XXX를 추출)
    EPOCH=$(basename "$MODEL_FILE" | sed -E 's/model_epoch_([0-9]+)\.pth/\1/')

    # TARGET_EPOCH이 설정된 경우, 해당 에폭에 대해서만 롤아웃을 진행
    if [ -z "$TARGET_EPOCH" ] || [ "$EPOCH" -eq "$TARGET_EPOCH" ]; then
      echo "Running rollout for model: $MODEL_FILE (Epoch: $EPOCH)"
      
      # python 명령어 실행 (추출한 epoch 값을 --epoch 인자로 추가)
      yes | DISPLAY=:1 python robomimic/scripts/rollout.py --config "$CONFIG_FILE" --ckpt "$MODEL_FILE" --rollout_num 50 --epoch "$EPOCH" --seed "$SEED" --name "$NAME"
      
      # 각 실행이 끝날 때까지 기다림
      wait
    fi

  else
    echo "No model files found in: $MODEL_DIR"
    exit 1
  fi
done