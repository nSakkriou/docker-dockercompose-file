from kafka import KafkaProducer
import time

producer = KafkaProducer(bootstrap_server="localhost:29092")

i = 0
while True:
    producer.send("quickstart-events", i)
    i += 1
    time.sleep(1)