# Robomimic

This repository is a fork of [robomimic](https://github.com/ARISE-Initiative/robomimic), a framework for robot learning from demonstration. This version includes specific configurations and scripts for our experiments.

## Installation

```bash
pip install -e .
```

## Usage

### Training

To train a policy using the final configuration:

```bash
python robomimic/scripts/train.py --config configs/rss2025/scbc_encoderfinal_libero8_augpolicy.json
```

### Rollout

To run rollouts for a trained model:

```bash
# Run rollout for a specific epoch
./robomimic/scripts/run_rollout_epoch.sh /path/to/experiment/folder <SEED> <NAME> <TARGET_EPOCH>

# Run rollout for all epochs
./robomimic/scripts/run_rollout.sh /path/to/experiment/folder <SEED> <NAME>
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
