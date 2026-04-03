# 每次重启都会自动加载 work_dirs 里的 last_checkpoint 继续训练
# COMMAND="CUDA_VISIBLE_DEVICES=3 python tools/train.py configs/oneformer3d_1xb4_scannet.py --resume"
COMMAND="CUDA_VISIBLE_DEVICES=2,3 torchrun --nproc_per_node=2 --master_port=29500 tools/train.py configs/oneformer3d_1xb4_scannet.py --launcher pytorch --resume"
LOG_FILE="/home/wanghao/Models/oneformer3d/work_dirs/exit_codes.log"

mkdir -p /home/wanghao/Models/oneformer3d/work_dirs

while true; do
    echo "========================================"
    echo "Starting training at $(date)"
    echo "========================================"
    
    # 运行训练脚本
    eval "$COMMAND"
    
    # 获取退出状态码
    EXIT_CODE=$?
    
    # 记录退出状态码到单独的日志文件
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Exit code: $EXIT_CODE" >> "$LOG_FILE"
    
    if [ $EXIT_CODE -eq 0 ]; then
        echo "Training finished successfully!"
        break
    else
        echo "Process crashed with exit code $EXIT_CODE. OOM or other error occurred."
        echo "Waiting for 60 seconds before retrying..."
        sleep 60  # 等待 60 秒，等别人释放显存或者让系统回收显存
    fi
done