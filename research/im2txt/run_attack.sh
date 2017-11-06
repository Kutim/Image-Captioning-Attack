#!/bin/bash
source activate tensorflow
cd ~/im2txt
DATA_FOLDER="/data/mscoco/image/val2014/"
IMAGE_FILE="${DATA_FOLDER}COCO_val2014_000000224477.jpg"
VOCAB_FILE="im2txt/pretrained/word_counts.txt"
CHECKPOINT_PATH="im2txt/pretrained/model2.ckpt-2000000"
CAPTION_FILE="/dccstor/dloptdata1/im2txt/data/mscoco/raw-data/annotations/captions_val2014.json"
IMAGE_DIRECTORY="/dccstor/dloptdata1/im2txt/data/mscoco/raw-data/val2014/"
bazel --output_user_root=/tmp/bazel_hzhang1 build -c opt im2txt/run_attack_BATCH_search_C
bazel-bin/im2txt/run_attack_BATCH_search_C   --checkpoint_path=${CHECKPOINT_PATH}  --caption_file=${CAPTION_FILE} --vocab_file=${VOCAB_FILE}   --input_files=${IMAGE_FILE} --image_directory=${IMAGE_DIRECTORY} --targeted=True --use_logits=True --exp_num=$2 --norm="l2" --offset=$1 --result_directory="/exact_sentence_experiment_results_l2/" -seed=8 --C=1 2>&1|tee exact_sentence_experiment_results_l2/log_$1.txt
source deactivate
