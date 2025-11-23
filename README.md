# Robomimic for UniSkill

This repository is the **policy learning component of UniSkill**, based on [robomimic](https://github.com/ARISE-Initiative/robomimic). It is used to train and evaluate policies for the UniSkill project.

## Installation

```bash
pip install -e .
```

## Prerequisites

Before training, ensure that you have prepared the necessary data.
- **Skill Directory**: You must extract or prepare the skill directory (skill embeddings/data) in advance before running the training script.

## Usage

### Training

To train the UniSkill policy using the default configuration:

```bash
python robomimic/scripts/train.py --config configs/uniskill/uniskill_policy.json
```

### Rollout

You can evaluate trained policies by running the `rollout.py` script directly. This script allows you to load a trained checkpoint and run evaluation episodes in the environment.

#### Basic Usage

```bash
python robomimic/scripts/rollout.py --config <CONFIG_PATH> --ckpt <CHECKPOINT_PATH> --task <TASK_NAME>
```

#### Arguments

| Argument | Description | Required | Default |
|----------|-------------|:--------:|:-------:|
| `--config` | Path to the config JSON file used for training. | Yes | - |
| `--ckpt` | Path to the model checkpoint (`.pth` file) to load. | Yes | - |
| `--task` | Name of the task to evaluate (e.g., `OpenDrawer`, `PnPCounterToCab`). | No | `opendrawer` |
| `--rollout_num` | Number of rollout episodes to run. | No | Config default |
| `--epoch` | Epoch number (used for logging purposes). | No | 0 |
| `--seed` | Random seed for the rollout. | No | Config default |
| `--name` | Experiment name suffix for logging. | No | None |
| `--debug` | Run in debug mode with fewer steps/episodes. | No | False |

#### Example

To run 50 evaluation episodes for the `OpenDrawer` task using a specific checkpoint:

```bash
python robomimic/scripts/rollout.py \
    --config configs/uniskill/uniskill_policy.json \
    --ckpt /path/to/experiment/models/model_epoch_100.pth \
    --task OpenDrawer \
    --rollout_num 50 \
    --seed 123
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
