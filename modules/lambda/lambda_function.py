import json
import boto3
import logging
from datetime import datetime

logger = logging.getLogger()
logger.setLevel(logging.INFO)


LABEL = 'cat'

s3_client = boto3.client('s3')
rekognition_client = boto3.client('rekognition')

def lambda_handler(event, context) : 
     
     logger.info(event)
     bucket = event['Records'][0]['s3']['bucket']['name']
     image = event['Records'][0]['s3']['object']['key']
     
     #Create Unique name for respond
     image_name = image.split('/')[-1]
     timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
     output_key = f'output/{image_name}_{timestamp}_rekognition_response.json'
     
     response = {'Status' : ' ', 'body' : []}
     
     
     
     try:
          response_rekognition = rekognition_client.detect_labels(
               Image={
                    'S3Object' : {
                         'Bucket' : bucket,
                         'Name' : image
                    }
               },
               MinConfidence = 70
          )
     
          detected_labels = []
     
          if 'Labels' in response_rekognition:
               for label in response_rekognition['Labels']:
                    detected_labels.append(label['Name'].lower())
               logger.info(f"Detected labels: {detected_labels}")
          
          
               if LABEL in detected_labels:
                    response['Status'] = f"Success.! {LABEL} found"
                    response['body'].append(response_rekognition['Labels']) 
               else:
                    response['Status'] = f"Failled.! {LABEL} Not found"
                    response['body'].append(response_rekognition['Labels']) 

     except Exception as error:
          logger.exception(f"Error calling Rekognition:{error}")
          return response  # Stop the function and return the error response
          
     try:
          s3_client.put_object(
               Bucket = bucket,
               Key = output_key,
               Body = json.dumps(response, indent=4)
          )
     except Exception as error :
          logger.exception(f"Error uploading to S3:{error}")
          
     
     return response     
     