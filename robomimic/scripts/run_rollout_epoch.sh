#!/bin/bash

# The first argument is used as the folder path.
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

# Set path for model files
MODEL_DIR="$FOLDER/models"

# Set path for config file
CONFIG_FILE="$FOLDER/config.json"

# Check if the model directory exists
if [ ! -d "$MODEL_DIR" ]; then
  echo "Error: Model directory not found: $MODEL_DIR"
  exit 1
fi

# Iterate over all model_epoch_*.pth files in the model directory
for MODEL_FILE in "$MODEL_DIR"/model_epoch_*.pth; do
  if [ -f "$MODEL_FILE" ]; then
    # Extract epoch number from filename (extract XXX from model_epoch_XXX.pth)
    EPOCH=$(basename "$MODEL_FILE" | sed -E 's/model_epoch_([0-9]+)\.pth/\1/')

    # If TARGET_EPOCH is set, run rollout only for that epoch
    if [ -z "$TARGET_EPOCH" ] || [ "$EPOCH" -eq "$TARGET_EPOCH" ]; then
      echo "Running rollout for model: $MODEL_FILE (Epoch: $EPOCH)"
      
      # Run python command (add extracted epoch value as --epoch argument)
      yes | python robomimic/scripts/rollout.py --config "$CONFIG_FILE" --ckpt "$MODEL_FILE" --rollout_num 50 --epoch "$EPOCH" --seed "$SEED" --name "$NAME"
      
      # Wait for each execution to finish
      wait
    fi

  else
    echo "No model files found in: $MODEL_DIR"
    exit 1
  fi
done