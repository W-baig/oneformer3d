# 每次重启都会自动加载 work_dirs 里的 last_checkpoint 继续训练
COMMAND="CUDA_VISIBLE_DEVICES=3 python tools/train.py configs/oneformer3d_1xb4_scannet.py --resume"

while true; do
    echo "========================================"
    echo "Starting training at $(date)"
    echo "========================================"
    
    # 运行训练脚本
    eval "$COMMAND"
    
    # 获取退出状态码
    EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        echo "Training finished successfully!"
        break
    else
        echo "Process crashed with exit code $EXIT_CODE. OOM or other error occurred."
        echo "Waiting for 60 seconds before retrying..."
        sleep 60  # 等待 60 秒，等别人释放显存或者让系统回收显存
    fi
done