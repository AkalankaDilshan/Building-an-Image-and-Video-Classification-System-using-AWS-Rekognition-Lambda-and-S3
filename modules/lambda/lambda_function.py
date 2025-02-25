import json
import boto3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


LABEL = 'Dog'

s3_client = boto3.client('s3')

def lambda_handler(event, context) : 
     
     logger.info(event)
     bucket = event['Records'][0]['s3']['bucket']['name']
     image = event['Records'][0]['s3']['object']['key']
     output_key = 'output/rekognition_response.json'
     response = {'Status' : 'Not Found', 'body' : []}
     
     rekognition_client = boto3.client('rekognition')
     
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
     
          detected_lables = []
     
          if response_rekognition['Labels']:
               for label in response_rekognition['Labels']:
                    detected_lables.append(label['Name'].lower())
               print(detected_lables)
          
          
               if LABEL in detected_lables:
                    response['Status'] = f"Success.! {LABEL} found"
                    response['body'].append(response_rekognition['Labels']) 
               else:
                    response['Status'] = f"Failled.! {LABEL} Not found"
                    response['body'].append(response_rekognition['Labels']) 

     except Exception as error:
          logger.error(error)          
          
     
     s3_client.put_object(
          Bucket = bucket,
          Key = output_key,
          Body = json.dumps(response, indent=4)
     )
     
     return response     
     