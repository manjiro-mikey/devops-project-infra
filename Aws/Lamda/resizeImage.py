import boto3
import os
import uuid
import urllib.parse
from PIL import Image

s3_client = boto3.client('s3')

# Lấy tên bucket đích từ biến môi trường
DEST_BUCKET = "tinacrm"

def resize_image(image_path, resized_path):
    with Image.open(image_path) as image:
        image.thumbnail((500, 500)) # Thay đổi kích thước tùy ý
        image.save(resized_path)

def lambda_handler(event, context):
    for record in event['Records']:
        source_bucket = record['s3']['bucket']['name']
        # Đảm bảo xử lý đúng các ký tự đặc biệt trong tên file
        key = urllib.parse.unquote_plus(record['s3']['object']['key'], encoding='utf-8')
        
        # Đường dẫn tạm thời trên Lambda (giới hạn 512MB mặc định)
        download_path = f'/tmp/{uuid.uuid4()}-{key}'
        upload_path = f'/tmp/resized-{key}'
        
        try:
            # 1. Tải ảnh từ S3 Input về Lambda /tmp
            s3_client.download_file(source_bucket, key, download_path)
            
            # 2. Resize ảnh
            resize_image(download_path, upload_path)
            
            # 3. Upload ảnh đã resize lên S3 Output
            s3_client.upload_file(upload_path, DEST_BUCKET, key)
            print(f"Successfully resized and uploaded {key} to {DEST_BUCKET}")
            
        except Exception as e:
            print(f"Error processing object {key} from bucket {source_bucket}. Event: {event}")
            raise e