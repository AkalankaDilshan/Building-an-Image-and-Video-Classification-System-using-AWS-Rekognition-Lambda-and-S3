import json
import boto3
import logging

logger = logging.getLogger()
logging.setLevel(logging.INFO)


LABEL = 'cat'

s3_client = boto3.client('s3')

def lambda_handler(event, context) : 
     
     logger.info(event)
     bucket = event['Records'][0]['bucket']['name']
     image = event['Records'][0]['object']['key']
     output_key = 'output/rekognition_response.json'
     response = {'Status' : 'Not Found', 'body' : []}
     
     rekognition_client = boto3.client('rekognition')
     
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
     
     if response_rekognition['']
     