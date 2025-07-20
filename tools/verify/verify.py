from mmdet3d.apis import init_model, inference_detector

config_file = '/home/wanghao/Models/oneformer3d/tools/pointpillars_hv_secfpn_8xb6-160e_kitti-3d-car.py'
checkpoint_file = '/home/wanghao/Models/oneformer3d/tools/hv_pointpillars_secfpn_6x8_160e_kitti-3d-car_20220331_134606-d42d15ed.pth'
model = init_model(config_file, checkpoint_file)
result = inference_detector(model, '/home/wanghao/Models/oneformer3d/demo/data/kitti/000008.bin')
print("result:", result)
print('Inference completed successfully!')